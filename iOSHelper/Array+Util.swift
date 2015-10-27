//
//  Array+Decompose.swift
//  KelvinAndrewCommon
//
//  Created by Kelvin Kosbab on 5/1/15.
//  Copyright (c) 2015 Kozinga. All rights reserved.
//

import Foundation

extension Array {
  var decompose : (head: Element, tail: [Element])? {
    return (count > 0) ? (self[0], Array(self[1..<count])) : nil
  }
  
  mutating func extractSample() -> Element? {
    if self.count > 0 {
      let randomIndex = Int(arc4random_uniform(UInt32(self.count)))
      return self.removeAtIndex(randomIndex)
    }
    return nil
  }
  
  func sample() -> Element? {
    if self.count > 0 {
      let randomIndex = Int(arc4random_uniform(UInt32(self.count)))
      return self[randomIndex]
    }
    return nil
  }
  
  // Safe Indexing (Swift 2.0)
  subscript (safe index: Int) -> Element? {
    return indices ~= index ? self[index] : nil
  }
}