//
//  MainTableViewController.swift
//  iOSHelper
//
//  Created by Kelvin Kosbab on 10/27/15.
//  Copyright © 2015 Kozinga. All rights reserved.
//

import Foundation
import UIKit

class MainTableViewController: MyTableViewController {
  
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
    var items: [MCCItem] = []
    items.append(MCCItem(title: "Option 1", callback: { () -> Void in
      print("Option 1 was selected")
    }))
    items.append(MCCItem(title: "Option 2", callback: { () -> Void in
      print("Option 2 was selected")
    }))
    items.append(MCCItem(title: "Option 3", callback: { () -> Void in
      print("Option 3 was selected")
    }))
    items.append(MCCItem(title: "Option 4", callback: { () -> Void in
      print("Option 4 was selected")
    }))
    
    let cancelItem = MCCItem(title: "Cancel") { () -> Void in
      print("Cancel selected")
    }
    
    MyCustomChooserViewController.presentMyCustomChooserViewController(self, chooserTitle: "Select An Option", chooserItems: items, cancelItem: cancelItem)
  }
  
  func showPickerChooser() {
    var items: [MCCItem] = []
    items.append(MCCItem(title: "Option 1", callback: { () -> Void in
      print("Picker 1 was selected")
    }))
    items.append(MCCItem(title: "Option 2", callback: { () -> Void in
      print("Picker 2 was selected")
    }))
    items.append(MCCItem(title: "Option 3", callback: { () -> Void in
      print("Picker 3 was selected")
    }))
    items.append(MCCItem(title: "Option 4", callback: { () -> Void in
      print("Picker 4 was selected")
    }))
    
    let cancelItem = MCCItem(title: "Cancel") { () -> Void in
      print("Cancel selected")
    }
    
    MyCustomChooserViewController.presentMyCustomChooserViewController(self, chooserTitle: "Pick an Option", chooserItems: items, isPicker: true, cancelItem: cancelItem)
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