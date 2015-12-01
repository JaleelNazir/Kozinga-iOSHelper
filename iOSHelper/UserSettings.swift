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
  
  @NSManaged private var someIntegerValue: NSNumber
  @NSManaged private var someFloatValue: NSNumber
  @NSManaged private var settingsEnumValue: NSNumber
  @NSManaged private var someBooleanValue: NSNumber
  @NSManaged var someString: String
  @NSManaged var someDate: NSDate
  @NSManaged private var myEntitiesSet: NSSet
  
  var myEntities: [SomeEntity] {
    if let objects = self.myEntitiesSet.sortedArrayUsingDescriptors(SomeEntity.sortDescriptors) as? [SomeEntity] {
      return objects
    }
    return []
  }
  
  var someInteger: Int {
    get {
      return Int(self.someIntegerValue)
    }
    set {
      self.someIntegerValue = NSNumber(integer: newValue)
    }
  }
  
  var someFloat: Float {
    get {
      return Float(self.someFloatValue)
    }
    set {
      self.someFloatValue = NSNumber(float: newValue)
    }
  }
  
  var settingsEnum: UserSettingsEnum {
    get {
      return UserSettingsEnum(rawValue: Int(self.settingsEnumValue))!
    }
    set {
      self.settingsEnumValue = newValue.rawValue
    }
  }
  
  var someBoolean: Bool {
    get {
      return Bool(self.someBooleanValue)
    }
    set {
      self.someBooleanValue = NSNumber(bool: newValue)
    }
  }
  
  // MARK: Class functions
  
  static let entityName: String = "UserSettings"
  
  static let NotificationSomeIntegerUpdated = "UserSettings.SomeInteger.updated"
  static let NotificationSomeFloatUpdated = "UserSettings.SomeFloat.updated"
  static let NotificationSomeEnumUpdated = "UserSettings.SomeEnum.updated"
  static let NotificationSomeBooleanUpdated = "UserSettings.SomeBoolean.updated"
  static let NotificationSomeStringUpdated = "UserSettings.SomeString.updated"
  static let NotificationSomeDateUpdated = "UserSettings.SomeDate.updated"
  
  class func fetch() -> UserSettings {
    if let object = self.fetchAll(self.entityName, sortDescriptors: nil).first as? UserSettings {
      return object
    }
    
    // If the settings have not been saved, create new settings with default values
    let createdSettings = self.insertIntoContext(self.entityName) as! UserSettings
    let defaultInt: Int = 1
    let defaultFloat: Float = 1.2
    let defaultEnum: UserSettingsEnum = .Setting1
    let defaultBool: Bool = false
    let defaultString: String = "Default"
    let defaultDate: NSDate = NSDate()
    self.update(defaultInt, someFloat: defaultFloat, settingsEnum: defaultEnum, someBoolean: defaultBool, someString: defaultString, someDate: defaultDate)
    return createdSettings
  }

  class private func update(someInteger: Int? = nil, someFloat: Float? = nil, settingsEnum: UserSettingsEnum? = nil, someBoolean: Bool? = nil, someString: String? = nil, someDate: NSDate? = nil) -> UserSettings {
    let userSettings = UserSettings.fetch()
    
    if let integer = someInteger {
      userSettings.someInteger = integer
      Notification.postNotification(NotificationSomeIntegerUpdated, object: integer)
    }
    
    if let float = someFloat {
      userSettings.someFloat = float
      Notification.postNotification(NotificationSomeFloatUpdated, object: float)
    }
    
    if let someEnum = settingsEnum {
      userSettings.settingsEnum = someEnum
      Notification.postNotification(NotificationSomeEnumUpdated)
    }
    
    if let bool = someBoolean {
      userSettings.someBoolean = bool
      Notification.postNotification(NotificationSomeBooleanUpdated, object: bool)
    }
    
    if let string = someString {
      userSettings.someString = string
      Notification.postNotification(NotificationSomeStringUpdated, object: string)
    }
    
    if let date = someDate {
      userSettings.someDate = date
      Notification.postNotification(NotificationSomeDateUpdated, object: date)
    }
    
    CoreDataStack.saveAllContexts()
    
    return userSettings
  }
  
  class func destroy() {
    self.destroyAll(self.entityName)
  }
  
  // MARK: Settings properties
  
  class var someInteger: Int {
    get {
      return self.fetch().someInteger
    }
    set {
      self.update(newValue)
    }
  }
  
  class var someFloat: Float {
    get {
      return self.fetch().someFloat
    }
    set {
      self.update(someFloat: newValue)
    }
  }
  
  class var settingsEnum: UserSettingsEnum {
    get {
      return self.fetch().settingsEnum
    }
    set {
      self.update(settingsEnum: newValue)
    }
  }
  
  class var someBoolean: Bool {
    get {
      return self.fetch().someBoolean
    }
    set {
      self.update(someBoolean: newValue)
    }
  }
  
  class var someString: String {
    get {
    return self.fetch().someString
    }
    set {
      self.update(someString: newValue)
    }
  }
  
  class var someDate: NSDate {
    get {
      return self.fetch().someDate
    }
    set {
      self.update(someDate: newValue)
    }
  }
  
}
