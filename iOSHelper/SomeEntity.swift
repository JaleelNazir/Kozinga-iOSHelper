//
//  SomeEntity.swift
//  iOSHelper
//
//  Created by Kelvin Kosbab on 11/2/15.
//  Copyright © 2015 Kozinga. All rights reserved.
//

import Foundation
import CoreData

enum EntityEnum: Int {
  case One=1, Two, Three
}

class SomeEntity: MyManagedObject {
  
  @NSManaged private var someIntegerValue: NSNumber
  @NSManaged private var someBooleanValue: NSNumber
  @NSManaged private var someEnumValue: NSNumber
  @NSManaged var name: String
  @NSManaged var date: NSDate
  @NSManaged var userSettings: UserSettings
  
  var someInteger: Int {
    get {
      return Int(self.someIntegerValue)
    }
    set {
      self.someIntegerValue = newValue
    }
  }
  
  var someBoolean: Bool {
    get {
      return Bool(self.someBooleanValue)
    }
    set {
      self.someBooleanValue = newValue
    }
  }
  
  var someEnum: EntityEnum {
    get {
      return EntityEnum(rawValue: Int(self.someEnumValue))!
    }
    set {
      self.someEnumValue = newValue.rawValue
    }
  }
  
  // MARK: Class functions
  
  static let entityName: String = "SomeEntity"
  static let uniqueQuery: String = "name"
  static let sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
  
  class func exists(name: String) -> Bool {
    return self.objectExists(self.entityName, uniqueQuery: "\(self.uniqueQuery) == %@", name)
  }
  
  class func count(name: String) -> Int {
    return self.count(self.entityName, uniqueQuery: "\(self.uniqueQuery) == %@", name)
  }
  
  class func count() -> Int {
    return self.countAll(self.entityName)
  }
  
  class func fetchAll() -> [SomeEntity] {
    if let objects = self.fetchAll(self.entityName, sortDescriptors: self.sortDescriptors) as? [SomeEntity] {
      return objects
    }
    return []
  }
  
  class func fetch(name: String) -> SomeEntity? {
    let objects = self.fetch(self.entityName, sortDescriptors: self.sortDescriptors, uniqueQuery: "\(self.uniqueQuery) == %@", name)
    if let object = objects.first as? SomeEntity {
      return object
    }
    return nil
  }
  
  class func createOrUpdate(name: String, date: NSDate, someInteger: Int, someBoolean: Bool, someEnum: EntityEnum, userSettings: UserSettings = UserSettings.fetch()) -> SomeEntity {
    var object: SomeEntity
    if let fetchedObject = self.fetch(name) {
      object = fetchedObject
    } else {
      object = self.insertIntoContext(self.entityName) as! SomeEntity
    }
    object.name = name
    object.date = date
    object.someInteger = someInteger
    object.someBoolean = someBoolean
    object.someEnum = someEnum
    object.userSettings = userSettings
    CoreDataStack.saveAllContexts()
    return object
  }
  
  class func destroyAll() {
    self.destroyAll(self.entityName)
  }
}
