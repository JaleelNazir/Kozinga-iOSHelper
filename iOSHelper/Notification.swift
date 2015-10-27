//
//  Notification.swift
//  WorkoutNow
//
//  Created by Kelvin Kosbab on 9/3/15.
//  Copyright (c) 2015 Kozinga. All rights reserved.
//

import Foundation

class Notification {
  
  static let DeviceFoundInRange = "com.kozinga.MyMetaWearProject.DeviceFoundInRange"
  
  class func addObserver(observer: AnyObject, selector: Selector, name: String) {
    self.addObserver(observer, selector: selector, name: name, object: nil)
  }
  
  class func addObserver(observer: AnyObject, selector: Selector, name: String, object: AnyObject?) {
    NSNotificationCenter.defaultCenter().addObserver(observer, selector: selector, name: name, object: object)
  }
  
  class func removeObserver(observer: AnyObject) {
    NSNotificationCenter.defaultCenter().removeObserver(observer)
  }
  
  class func postNotification(name: String, object: AnyObject? = nil, userInfo: [NSObject : AnyObject]? = nil) {
    NSNotificationCenter.defaultCenter().postNotificationName(name, object: object, userInfo: userInfo)
  }
  
}