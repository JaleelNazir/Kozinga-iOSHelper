//
//  UIFont+Util.swift
//  WorkoutNow
//
//  Created by Kelvin Kosbab on 9/3/15.
//  Copyright (c) 2015 Kozinga. All rights reserved.
//

import Foundation
import UIKit

extension UIFont {
  
  static var applicationFontName: String {
    return "Optima-Regular"
  }
  
  static var applicationFontNameBold: String {
    return "Optima-Bold"
  }
  
  static var smallTextSize: CGFloat {
    return 13
  }
  
  static var mediumTextSize: CGFloat {
    return 15
  }
  
  static var largeTextSize: CGFloat {
    return 18
  }
  
  class var applicationFontSmall: UIFont {
    return UIFont(name: self.applicationFontName, size: self.smallTextSize)!
  }
  
  class var applicationFontMedium: UIFont {
    return UIFont(name: self.applicationFontName, size: self.mediumTextSize)!
  }
  
  class var applicationFontLarge: UIFont {
    return UIFont(name: self.applicationFontName, size: self.largeTextSize)!
  }
  
  class var applicationBoldFontSmall: UIFont {
    return UIFont(name: self.applicationFontNameBold, size: self.smallTextSize)!
  }
  
  class var applicationBoldFontMedium: UIFont {
    return UIFont(name: self.applicationFontNameBold, size: self.mediumTextSize)!
  }
  
  class var applicationBoldFontLarge: UIFont {
    return UIFont(name: self.applicationFontNameBold, size: self.largeTextSize)!
  }
  
  class func applicationFont(size: CGFloat) -> UIFont {
    return UIFont(name: self.applicationFontName, size: size)!
  }
  
  class func applicationBoldFont(size: CGFloat) -> UIFont {
    return UIFont(name: self.applicationFontNameBold, size: size)!
  }
}