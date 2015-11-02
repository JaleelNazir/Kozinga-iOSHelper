//
//  Util.swift
//  iOSHelper
//
//  Created by Kelvin Kosbab on 9/2/15.
//  Copyright (c) 2015 Kozinga. All rights reserved.
//

import Foundation
import UIKit

// MARK: Global dispatch queue for dispatch_async

var GlobalMainQueue: dispatch_queue_t {
  return dispatch_get_main_queue()
}

var GlobalUserInteractiveQueue: dispatch_queue_t {
  return dispatch_get_global_queue(QOS_CLASS_USER_INTERACTIVE, 0)
}

var GlobalUserInitiatedQueue: dispatch_queue_t {
  return dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0)
}

var GlobalUtilityQueue: dispatch_queue_t {
  return dispatch_get_global_queue(QOS_CLASS_UTILITY, 0)
}

var GlobalBackgroundQueue: dispatch_queue_t {
  return dispatch_get_global_queue(QOS_CLASS_BACKGROUND, 0)
}

class Util {
  
  // MARK: Cookies
  
  class func setCookies(cookies: [NSHTTPCookie], url: NSURL) {
    NSHTTPCookieStorage.sharedHTTPCookieStorage().setCookies(cookies, forURL: url, mainDocumentURL: nil)
  }
  
  class func getCookies() -> [NSHTTPCookie] {
    if let cookies = NSHTTPCookieStorage.sharedHTTPCookieStorage().cookies {
      return cookies
    }
    return []
  }
  
  // MARK: Parsing data
  
  class func dataToHex(data: NSData) -> String {
    var str: String = String()
    let p = UnsafePointer<UInt8>(data.bytes)
    let len = data.length
    
    for var i=0; i<len; ++i {
      str += String(format: "%02.2X", p[i])
    }
    return str
  }
  
  // Navigation buttons
  
  class func imageToNavigationButton(named: String, target: AnyObject?, action: Selector, forControlEvents: UIControlEvents) -> UIBarButtonItem {
    let button = UIButton(frame: CGRectMake(0, 0, 25, 25))
    let image = UIImage(named: named)!.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
    button.setImage(image, forState: .Normal)
    button.tintColor = UIColor.blueColor()
    button.addTarget(target, action: action, forControlEvents: forControlEvents)
    
    let navigationButton = UIBarButtonItem()
    navigationButton.customView = button
    
    return navigationButton
  }
  
  class func titleToNavigationButton(title: String, target: AnyObject?, action: Selector, forControlEvents: UIControlEvents) -> UIBarButtonItem {
    let button = UIButton(frame: CGRectMake(0, 0, 25, 25))
    button.setTitle(title, forState: .Normal)
    button.setTitleColor(UIColor.blackColor(), forState: .Normal)
    button.addTarget(target, action: action, forControlEvents: forControlEvents)
    
    let navigationButton = UIBarButtonItem()
    navigationButton.customView = button
    
    return navigationButton
  }
  
  // Ratings
  
  class func rateApp() {
    let APP_ID = "123456789"
    if let appStoreURL = NSURL(string: "itms-apps://itunes.apple.com/app/id\(APP_ID)?mt=8") where UIApplication.sharedApplication().canOpenURL(appStoreURL) {
      UIApplication.sharedApplication().openURL(appStoreURL)
    } else if let appStoreURL = NSURL(string: "http://itunes.apple.com/app/id\(APP_ID)?mt=8") where UIApplication.sharedApplication().canOpenURL(appStoreURL) {
      UIApplication.sharedApplication().openURL(appStoreURL)
    } else {
      NSLog("Failed to open app store")
    }
  }
}