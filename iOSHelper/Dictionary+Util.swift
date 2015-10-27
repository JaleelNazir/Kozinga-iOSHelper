//
//  Dictionary+URLEncoding.swift
//  KelvinAndrewCommon
//
//  Created by Kelvin Kosbab on 5/12/15.
//  Copyright (c) 2015 Kozinga. All rights reserved.
//

import Foundation

extension Dictionary {
  
  func urlEncodedString() -> String {
    var urlString = ""
    for (paramNameObject, paramValueObject) in self {
      if let key = paramNameObject as? String, encodedKey = key.urlEncoded, value = paramValueObject as? String, encodedValue = value.urlEncoded {
        let oneUrlPiece = encodedKey + "=" + encodedValue
        urlString = urlString + (urlString == "" ? "" : "&") + oneUrlPiece
      }
    }
    return urlString
  }
}