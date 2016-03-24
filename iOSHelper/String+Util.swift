//
//  String+Helper.swift
//  KelvinAndrew
//
//  Created by Kelvin Kosbab on 6/5/15.
//  Copyright (c) 2015 Kozinga. All rights reserved.
//

import Foundation
import UIKit

extension String {
  
  func heightWithConstrainedWidth(label: UILabel) -> CGFloat {
    let width = label.bounds.width
    let font = label.font
    return self.heightWithConstrainedWidth(width, font: font)
  }
  
  func heightWithConstrainedWidth(width: CGFloat, font: UIFont) -> CGFloat {
    let constraintRect = CGSize(width: width, height: CGFloat.max)
    let boundingBox = self.boundingRectWithSize(constraintRect, options: .UsesLineFragmentOrigin, attributes: [NSFontAttributeName: font], context: nil)
    return boundingBox.height
  }
  
  static func trim(string: String) -> String {
    return string.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
  }
  
  func trim() -> String {
    return self.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
  }
  
  mutating func trim() {
    self = self.trim()
  }
  
  var urlEncoded: String? {
    return self.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())
  }
  
  func contains(string: String) -> Bool {
    return self.rangeOfString(string) != nil
  }
  
  func containsIgnoreCase(string: String) -> Bool {
    return self.lowercaseString.rangeOfString(string.lowercaseString) != nil
  }
  
  // MARK: Subscript operators
  
  subscript (i: Int) -> Character {
    return self[self.startIndex.advancedBy(i)]
  }
  
  subscript (i: Int) -> String {
    return String(self[i] as Character)
  }
  
  subscript (r: Range<Int>) -> String {
    let start = startIndex.advancedBy(r.startIndex)
    let end = start.advancedBy(r.endIndex - r.startIndex)
    return self[start..<end]
  }
}