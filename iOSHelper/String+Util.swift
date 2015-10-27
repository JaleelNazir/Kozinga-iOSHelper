//
//  String+Helper.swift
//  KelvinAndrew
//
//  Created by Kelvin Kosbab on 6/5/15.
//  Copyright (c) 2015 Kozinga. All rights reserved.
//

import Foundation

extension String {
  
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
}