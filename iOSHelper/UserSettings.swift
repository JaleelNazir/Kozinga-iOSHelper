//
//  UserSettings.swift
//  iOSHelper
//
//  Created by Kelvin Kosbab on 10/27/15.
//  Copyright © 2015 Kozinga. All rights reserved.
//

import Foundation
import CoreData

enum UserSettingsEnum: Int {
  case Setting1=1, Setting2, Setting3, Setting4
}

class UserSettings: MyManagedObject {
  
  @NSManaged private var someIntegerValue: NSNumber?
  @NSManaged private var someFloatValue: NSNumber?
  @NSManaged private var settingsEnumValue: NSNumber?
  @NSManaged private var someBooleanValue: NSNumber?
  @NSManaged var someString: String?
  @NSManaged var someDate: NSDate?
  @NSManaged private var myEntitiesSet: NSSet
  
  private var myEntities: [SomeEntity] {
    if let objects = self.myEntitiesSet.sortedArrayUsingDescriptors(SomeEntity.sortDescriptors) as? [SomeEntity] {
      return objects
    }
    return []
  }
  
  private static let someIntegerDefault: Int = 2
  private var someInteger: Int {
    get {
      if let value = self.someIntegerValue {
        return Int(value)
      }
      self.someInteger = UserSettings.someIntegerDefault
      return UserSettings.someIntegerDefault
    }
    set {
      self.someIntegerValue = newValue
      CoreDataStack.saveAllContexts()
    }
  }
  
  private static let someFloatDefault: Float = 1.2
  private var someFloat: Float {
    get {
      if let value = self.someFloatValue {
        return Float(value)
      }
      self.someFloat = UserSettings.someFloatDefault
      return UserSettings.someFloatDefault
    }
    set {
      self.someFloatValue = newValue
      CoreDataStack.saveAllContexts()
    }
  }
  
  private static let settingsEnumDefault: UserSettingsEnum = .Setting2
  private var settingsEnum: UserSettingsEnum {
    get {
      if let value = self.settingsEnumValue, setting = UserSettingsEnum(rawValue: Int(value)) {
        return setting
      }
      self.settingsEnum = UserSettings.settingsEnumDefault
      return UserSettings.settingsEnumDefault
    }
    set {
      self.settingsEnumValue = newValue.rawValue
      CoreDataStack.saveAllContexts()
    }
  }
  
  private static let someBooleanDefault: Bool = false
  private var someBoolean: Bool {
    get {
      if let value = self.someBooleanValue {
        return Bool(value)
      }
      self.someBoolean = UserSettings.someBooleanDefault
      return UserSettings.someBooleanDefault
    }
    set {
      self.someBooleanValue = newValue
      CoreDataStack.saveAllContexts()
    }
  }
  
  // MARK: Class functions
  
  static let entityName: String = "UserSettings"
  
  class func fetch() -> UserSettings {
    if let object = self.fetchAll(self.entityName, sortDescriptors: nil).first as? UserSettings {
      return object
    }
    return self.insertIntoContext(self.entityName) as! UserSettings
  }
  
  class func clear() {
    self.destroyAll(self.entityName)
  }
  
  // MARK: Settings properties
  
  class var myEntities: [SomeEntity] {
    return self.fetch().myEntities
  }
  
  class var someInteger: Int {
    get {
      return self.fetch().someInteger
    }
    set {
      self.fetch().someInteger = newValue
    }
  }
  
  class var someFloat: Float {
    get {
      return self.fetch().someFloat
    }
    set {
      self.fetch().someFloat = newValue
    }
  }
  
  class var settingsEnum: UserSettingsEnum {
    get {
      return self.fetch().settingsEnum
    }
    set {
      self.fetch().settingsEnum = newValue
    }
  }
  
  class var someBoolean: Bool {
    get {
      return self.fetch().someBoolean
    }
    set {
      self.fetch().someBoolean = newValue
    }
  }
  
  class var someString: String? {
    get {
      return self.fetch().someString
    }
    set {
      self.fetch().someString = newValue
    }
  }
  
  class var someDate: NSDate? {
    get {
      return self.fetch().someDate
    }
    set {
      self.fetch().someDate = newValue
    }
  }
  
  // MARK: DEBUG
  
  class func debug() {
    print("someInteger : \(self.someInteger)")
    print("someInteger : \(self.someFloat)")
    print("someInteger : \(self.settingsEnum)")
    print("someInteger : \(self.someBoolean)")
    print("someInteger : \(self.someString)")
    print("someInteger : \(self.someDate)")
  }
}
