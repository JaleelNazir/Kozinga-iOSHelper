//
//  UIColor+AppColors.swift
//  KelvinAndrew
//
//  Created by Kelvin Kosbab on 5/11/15.
//  Copyright (c) 2015 Kozinga. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
  
  class var applicationPrimaryColor: UIColor {
    return UIColor.blackColor()
  }
  
  class var chooserHighlightColor: UIColor {
    return UIColor.colorFromHex("#E6E6E6")
  }
  
  class var chooserBackgroundColor: UIColor {
    return UIColor.colorFromHex("#F2F2F2")
  }
  
  // MARK: Navigation controller colors
  
  class var navigationBarColor: UIColor {
    return self.blueColor()
  }
  
  class var navigationBarTextColor: UIColor {
    return self.whiteColor()
  }
  
  class var navigationBarButtonColor: UIColor {
    return self.whiteColor()
  }
  
  class var tabBarColor: UIColor {
    return self.blueColor()
  }
  
  // MARK: Button Colors
  
  class var buttonTextColor: UIColor {
    return self.whiteColor()
  }
  
  // MARK: Util
  
  class public func colorFromHash(hash: Int) -> UIColor {
    let red = Double((hash >> 16) & 0xFF) / 255.0
    let green = Double((hash >> 8) & 0xFF) / 255.0
    let blue = Double(hash & 0xFF) / 255.0
    return UIColor(red: CGFloat(red), green:CGFloat(green), blue: CGFloat(blue), alpha: CGFloat(1.0))
  }
  
  class public func colorFromHex(hex: String) -> UIColor {
    var cString:String = hex.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet() as NSCharacterSet).uppercaseString
    
    if (cString.hasPrefix("#")) {
      cString = cString.substringFromIndex(cString.startIndex.advancedBy(1))
    }
    
    if (cString.characters.count != 6) {
      return UIColor.grayColor()
    }
    
    var rgbValue:UInt32 = 0
    NSScanner(string: cString).scanHexInt(&rgbValue)
    
    return UIColor(
      red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
      green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
      blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
      alpha: CGFloat(1.0)
    )
  }
  
  public func hexString() -> String {
    var rFloat: CGFloat = 0.0
    var gFloat: CGFloat = 0.0
    var bFloat: CGFloat = 0.0
    var aFloat: CGFloat = 0.0
    self.getRed(&rFloat, green: &gFloat, blue: &bFloat, alpha: &aFloat)
    let r = (Int)(255.0 * rFloat);
    let g = (Int)(255.0 * gFloat);
    let b = (Int)(255.0 * bFloat);
    _ = (Int)(255.0 * aFloat); // a
    let hex = String(format: "%02x%02x%02x", r, g, b)
    return hex
  }
}