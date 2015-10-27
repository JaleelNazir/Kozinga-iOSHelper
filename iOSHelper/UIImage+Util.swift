//
//  UIImage+Helper.swift
//  KelvinAndrew
//
//  Created by Kelvin Kosbab on 6/6/15.
//  Copyright (c) 2015 Kozinga. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
  
  var data: NSData? {
    return UIImagePNGRepresentation(self)
  }
  
  func copyToClipboard() {
    UIPasteboard.generalPasteboard().image = self
  }
  
  func saveToPhotos() {
    UIImageWriteToSavedPhotosAlbum(self, nil, nil, nil)
  }
  
  func saveToDocuments(filename: String) {
    let tmpURL = NSURL(fileURLWithPath: NSTemporaryDirectory()).URLByAppendingPathComponent(filename)
    if let data = UIImagePNGRepresentation(self) {
      data.writeToURL(tmpURL, atomically: true)
      NSLog("Saved to TemporaryDirectory \(tmpURL.path)")
    } else {
      NSLog("Failed to save to TemporaryDirectory")
    }
  }
  
  class func saveUIImageToDocuments(image: UIImage, filename: String) {
    let tmpURL = NSURL(fileURLWithPath: NSTemporaryDirectory()).URLByAppendingPathComponent(filename)
    
    if let data = UIImagePNGRepresentation(image) {
      data.writeToURL(tmpURL, atomically: true)
      NSLog("Saved to TemporaryDirectory \(tmpURL.path)")
    } else {
      NSLog("Failed to save to TemporaryDirectory")
    }
  }
  
  class func fetchURLForSavedImage(filename: String) -> NSURL? {
    let tmpURL = NSURL(fileURLWithPath: NSTemporaryDirectory()).URLByAppendingPathComponent(filename)
    let fileManager = NSFileManager.defaultManager()
    if let path = tmpURL.path where fileManager.fileExistsAtPath(path) {
      return tmpURL
    }
    return nil
  }
  
  class func fetchUIImageFromDocuments(filename: String) -> UIImage? {
    let tmpURL = NSURL(fileURLWithPath: NSTemporaryDirectory()).URLByAppendingPathComponent(filename)
    let fileManager = NSFileManager.defaultManager()
    if let path = tmpURL.path where fileManager.fileExistsAtPath(path) {
      return UIImage(contentsOfFile: path)
    }
    return nil
  }
  
  class func clearUIImageFromDocuments(filename: String) {
    let tmpURL = NSURL(fileURLWithPath: NSTemporaryDirectory()).URLByAppendingPathComponent(filename)
    let fileManager = NSFileManager.defaultManager()
    if let path = tmpURL.path where fileManager.isDeletableFileAtPath(path) {
      do {
        try fileManager.removeItemAtURL(tmpURL)
        NSLog("clearUIImageFromDocuments successfully cleared image \(filename)")
      } catch {
        NSLog("clearUIImageFromDocuments failed to clear image \(filename)")
      }
    }
  }
}