//
//  CoreDataStack.swift
//  iOSHelper
//
//  Created by Kelvin Kosbab on 6/19/15.
//  Copyright (c) 2015 Kozinga. All rights reserved.
//

import Foundation
import CoreData

class CoreDataStack: NSObject {
  
  private static let NOTIFICATION_CONTEXT_ALL_SAVE = "CoreDataStack.context.all.save"
  private static let NOTIFICATION_CONTEXT_ALL_ROLLBACK = "CoreDataStack.context.all.rollback"
  private static let NOTIFICATION_CONTEXT_MAIN_SAVE = "CoreDataStack.context.main.save"
  private static let NOTIFICATION_CONTEXT_MAIN_ROLLBACK = "CoreDataStack.context.main.rollback"
  private static let NOTIFICATION_CONTEXT_BACKGROUND_SAVE = "CoreDataStack.context.background.save"
  private static let NOTIFICATION_CONTEXT_BACKGROUND_ROLLBACK = "CoreDataStack.context.background.rollback"
  
  let modelName: String
  let storeName: String
  var options: [NSObject: AnyObject]?
  
  class func getInstance() -> CoreDataStack {
    let coreDataStack = CoreDataStack()
    coreDataStack.configure()
    return coreDataStack
  }
  
  class func saveAllContexts(sender: AnyObject? = nil) {
    NSNotificationCenter.defaultCenter().postNotificationName(NOTIFICATION_CONTEXT_ALL_SAVE, object: sender)
  }
  
  class func rollbackAllContexts(sender: AnyObject? = nil) {
    NSNotificationCenter.defaultCenter().postNotificationName(NOTIFICATION_CONTEXT_ALL_ROLLBACK, object: sender)
  }
  
  class func saveMainContext(sender: AnyObject? = nil) {
    NSNotificationCenter.defaultCenter().postNotificationName(NOTIFICATION_CONTEXT_MAIN_SAVE, object: sender)
  }
  
  class func rollbackMainContext(sender: AnyObject? = nil) {
    NSNotificationCenter.defaultCenter().postNotificationName(NOTIFICATION_CONTEXT_MAIN_ROLLBACK, object: sender)
  }
  
  class func saveBackgroundContext(sender: AnyObject? = nil) {
    NSNotificationCenter.defaultCenter().postNotificationName(NOTIFICATION_CONTEXT_BACKGROUND_SAVE, object: sender)
  }
  
  class func rollbackBackgroundContext(sender: AnyObject? = nil) {
    NSNotificationCenter.defaultCenter().postNotificationName(NOTIFICATION_CONTEXT_BACKGROUND_ROLLBACK, object: sender)
  }
  
  private init(modelName: String = "iOSHelper", storeName: String = "iOSHelper", options: [NSObject: AnyObject]? = [NSMigratePersistentStoresAutomaticallyOption: true, NSInferMappingModelAutomaticallyOption: true]) {
    self.modelName = modelName
    self.storeName = storeName
    self.options = options
  }
  
  func configure() {
    let notificationCenter = NSNotificationCenter.defaultCenter()
    notificationCenter.addObserver(self, selector: #selector(self.save), name: CoreDataStack.NOTIFICATION_CONTEXT_ALL_SAVE, object: nil)
    notificationCenter.addObserver(self, selector: #selector(self.rollback), name: CoreDataStack.NOTIFICATION_CONTEXT_ALL_ROLLBACK, object: nil)
    notificationCenter.addObserver(self, selector: #selector(self.saveMainContext), name: CoreDataStack.NOTIFICATION_CONTEXT_MAIN_SAVE, object: nil)
    notificationCenter.addObserver(self, selector: #selector(self.rollbackMainContext), name: CoreDataStack.NOTIFICATION_CONTEXT_MAIN_ROLLBACK, object: nil)
    notificationCenter.addObserver(self, selector: #selector(self.saveBackgroundContext), name: CoreDataStack.NOTIFICATION_CONTEXT_BACKGROUND_SAVE, object: nil)
    notificationCenter.addObserver(self, selector: #selector(self.rollbackBackgroundContext), name: CoreDataStack.NOTIFICATION_CONTEXT_BACKGROUND_ROLLBACK, object: nil)
    
      notificationCenter.addObserver(self, selector: #selector(self.managedObjectSaved(_:)), name: NSManagedObjectContextDidSaveNotification, object: nil)
  }
  
  deinit {
    NSNotificationCenter.defaultCenter().removeObserver(self)
  }
  
  var applicationDocumentsDirectory: NSURL = {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "com.kozinga.something" in the application's documents Application Support directory.
    let urls = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
    return urls[urls.count-1]
    }()
  
  var storeURL: NSURL {
    return self.applicationDocumentsDirectory.URLByAppendingPathComponent("\(self.storeName).sqlite")
  }
  
  var modelURL: NSURL {
    return NSBundle.mainBundle().URLForResource(self.modelName, withExtension: "momd")!
  }
  
  lazy var model: NSManagedObjectModel = NSManagedObjectModel(contentsOfURL: self.modelURL)!
  
  var store : NSPersistentStore?
  
  private var _coordinator: NSPersistentStoreCoordinator? = nil
  var coordinator: NSPersistentStoreCoordinator {
    if _coordinator == nil {
      let coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.model)
      
      do {
        self.store = try coordinator.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: self.storeURL, options: self.options)
      } catch let error as NSError {
        NSLog("store error \(error)")
      }
      _coordinator = coordinator
    }
    return _coordinator!
  }
  
  private var _context: NSManagedObjectContext? = nil
  var context: NSManagedObjectContext {
    if self._context == nil {
      let context = NSManagedObjectContext(concurrencyType: .MainQueueConcurrencyType)
      context.persistentStoreCoordinator = self.coordinator
      self._context = context
    }
    return self._context!
  }
  
  private var _backgroundContext: NSManagedObjectContext? = nil
  var backgrondContext : NSManagedObjectContext {
    if self._backgroundContext == nil {
      let context = NSManagedObjectContext(concurrencyType: NSManagedObjectContextConcurrencyType.PrivateQueueConcurrencyType)
      context.persistentStoreCoordinator = self.coordinator
      self._backgroundContext = context
    }
    return self._backgroundContext!
  }
  
  func saveMainContext() {
    if self.context.hasChanges {
      do {
        try self.context.save()
      } catch {
        let nserror = error as NSError
        nserror.localizedDescription
        NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
        self.context.reset();
      }
    }
  }
  
  func rollbackMainContext() {
    self.context.rollback();
  }
  
  func saveBackgroundContext() {
    if self.backgrondContext.hasChanges {
      do {
        try self.backgrondContext.save()
      } catch {
        let nserror = error as NSError
        NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
        self.backgrondContext.reset();
      }
    }
  }
  
  func rollbackBackgroundContext() {
    self.backgrondContext.rollback();
  }
  
  func save() {
    self.saveMainContext()
    self.saveBackgroundContext()
  }
  
  func rollback() {
    self.rollbackMainContext()
    self.rollbackBackgroundContext()
  }
  
  // MARK: Notifications
  
  func managedObjectSaved(notification: NSNotification) {
    if let notificationContext = notification.object as? NSManagedObjectContext {
      if notificationContext == self.context {
        self.backgrondContext.mergeChangesFromContextDidSaveNotification(notification)
      } else if notificationContext == self.backgrondContext {
        self.context.mergeChangesFromContextDidSaveNotification(notification)
      }
    }
  }
}