//
//  KAManagedObject.swift
//  iOSHelper
//
//  Created by Kelvin Kosbab on 6/19/15.
//  Copyright (c) 2015 Kozinga. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class MyManagedObject: NSManagedObject {
  
  static var managedContext: NSManagedObjectContext? {
    return AppDelegate.get().coreDataStack.context
  }
  
  static var managedBackgroundContext: NSManagedObjectContext? {
    return AppDelegate.get().coreDataStack.backgrondContext
  }
  
  class func getEntity(entityName: String, context: NSManagedObjectContext) -> NSEntityDescription? {
    return NSEntityDescription.entityForName(entityName, inManagedObjectContext: context)
  }
  
  class func getObject(entity: NSEntityDescription, context: NSManagedObjectContext) -> NSManagedObject? {
    return NSManagedObject(entity: entity, insertIntoManagedObjectContext: context)
  }
  
  class func insertIntoContext(entityName: String, inMainContext: Bool = true) -> NSManagedObject? {
    if let context = inMainContext ? self.managedContext : self.managedBackgroundContext {
      return NSEntityDescription.insertNewObjectForEntityForName(entityName, inManagedObjectContext: context)
    }
    return nil
  }
  
  class func getObject(entityName: String) -> NSManagedObject? {
    if let context = self.managedContext, entity = self.getEntity(entityName, context: context), object = self.getObject(entity, context: context) {
      return object
    }
    return nil
  }
  
  class func count(entityName: String, uniqueQuery: String, _ args: CVarArgType...) -> Int {
    if let context = self.managedContext {
      let request = NSFetchRequest()
      request.entity = self.getEntity(entityName, context: context)
      request.predicate = NSPredicate(format: uniqueQuery, arguments: getVaList(args))
      request.returnsObjectsAsFaults = false
      
      var error: NSError?
      let count = context.countForFetchRequest(request, error: &error)
      let result = (count != NSNotFound) ? count : 0;
      return result
    }
    return 0
  }
  
  class func countAll(entityName: String) -> Int {
    if let context = self.managedContext {
      let request = NSFetchRequest()
      request.entity = self.getEntity(entityName, context: context)
      request.returnsObjectsAsFaults = false
      
      var error: NSError?
      let count = context.countForFetchRequest(request, error: &error)
      let result = (count != NSNotFound) ? count : 0;
      return result
    }
    return 0
  }
  
  class func objectExists(entityName: String, uniqueQuery: String, _ args: CVarArgType...) -> Bool {
    if let context = self.managedContext {
      let request = NSFetchRequest()
      request.entity = self.getEntity(entityName, context: context)
      request.predicate = NSPredicate(format: uniqueQuery, arguments: getVaList(args))
      request.returnsObjectsAsFaults = false
      
      var error: NSError?
      let count = context.countForFetchRequest(request, error: &error)
      let result = (count != NSNotFound) ? count : 0;
      return result > 0
    }
    return false
  }
  
  // MARK: Fetch
  
  class func fetchAll(entityName: String, sortDescriptors: [NSSortDescriptor]? = nil, inMainContext: Bool = true) -> [NSManagedObject] {
    if let context = inMainContext ? self.managedContext : self.managedBackgroundContext {
      let request = NSFetchRequest()
      request.entity = self.getEntity(entityName, context: context)
      request.sortDescriptors = sortDescriptors
      request.returnsObjectsAsFaults = false
      
      do {
        if let objects = try context.executeFetchRequest(request) as? [NSManagedObject] {
          return objects
        } else {
          NSLog("fetchAll: Failed to cast to NSManagedObject")
        }
      } catch let error as NSError {
        NSLog("fetchAll: \(error.localizedDescription)")
      }
    }
    return []
  }
  
  class func fetch(entityName: String, sortDescriptors: [NSSortDescriptor]? = nil, inMainContext: Bool = true, uniqueQuery: String, _ args: CVarArgType...) -> [NSManagedObject] {
    if let context = inMainContext ? self.managedContext : self.managedBackgroundContext {
      let request = NSFetchRequest()
      request.entity = self.getEntity(entityName, context: context)
      request.predicate = NSPredicate(format: uniqueQuery, arguments: getVaList(args))
      request.sortDescriptors = sortDescriptors
      request.returnsObjectsAsFaults = false
      
      return fetch(request, context: context)
    }
    return []
  }
  
  class func fetch(request: NSFetchRequest, context: NSManagedObjectContext) -> [NSManagedObject] {
    do {
      if let objects = try context.executeFetchRequest(request) as? [NSManagedObject] {
        return objects
      } else {
        NSLog("fetch: Failed to cast to NSManagedObject")
      }
    } catch let error as NSError {
      NSLog("fetch: \(error.localizedDescription)")
    }
    return []
  }
  
  // MARK: Destroy
  
  class func destroy(object: NSManagedObject) {
    self.destroyObject(object)
  }
  
  class func destroyObject(object: NSManagedObject) {
    if let context = self.managedContext {
      destroyObject(object, context: context)
    }
  }
  
  class func destroyObject(object: NSManagedObject, context: NSManagedObjectContext) {
    context.deleteObject(object)
  }
  
  class func destroyAll(entityName: String) {
    if let context = self.managedContext {
      for object in self.fetchAll(entityName) {
        self.destroyObject(object, context: context)
      }
    }
  }
  
  // MARK: Save context
  
  class func save() {
    CoreDataStack.saveAllContexts()
  }
}