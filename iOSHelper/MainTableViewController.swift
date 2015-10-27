//
//  MainTableViewController.swift
//  iOSHelper
//
//  Created by Kelvin Kosbab on 10/27/15.
//  Copyright © 2015 Kozinga. All rights reserved.
//

import Foundation
import UIKit

class MainTableViewController: MyTableViewController, MyCustomChooserViewControllerDelegate {
  
  // MARK: Table view
  
  override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    tableView.deselectRowAtIndexPath(indexPath, animated: true)
    
    if indexPath.section == 0 {
      
      // MY STANDARD CHOOSER
      if indexPath.row == 0 {
        self.showStandardChooser()
      } else if indexPath.row == 1 {
        self.showPickerChooser()
      }
      
    } else if indexPath.section == 1 {
      
      // LOADING
      self.showLoading()
    }
  }
  
  // MARK: My Custom Chooser
  
  func showStandardChooser() {
    MyCustomChooserViewController.presentMyCustomChooserViewController(self, chooserObjectKey: "objectOfInterst", chooserTitle: "Select An Option", chooserItems: ["Option 1", "Option 2", "Option 3", "Option 4"], delegate: self, isCancelOption: true)
  }
  
  func showPickerChooser() {
    MyCustomChooserViewController.presentMyCustomChooserViewController(self, chooserObjectKey: "objectOfInterst", chooserTitle: "Pick an Option", chooserItems: ["Picker 1", "Picker 2", "Picker 3", "Picker 4"], delegate: self, isPicker: true, isCancelOption: true)
  }
  
  func myCustomChooserIndexSelected(key: String, index: Int, title: String) {
    if key == "objectOfInterst" {
      NSLog("Option at index \(index) was selected with title \(title)")
    }
  }
  
  func myCustomChooserChooserCancelSelected(key: String) {
    NSLog("Cancel was selected")
  }
  
  // MARK: Loading
  
  func showLoading() {
    LoadingViewController.showLoading(self, loadingText: "Custom Loading Text!") { () -> Void in
      let popTime = dispatch_time(DISPATCH_TIME_NOW, Int64(Double(3) * Double(NSEC_PER_SEC)))
      dispatch_after(popTime, GlobalMainQueue) {
        LoadingViewController.dismissLoading()
      }
    }
  }
}