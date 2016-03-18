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
      
    } else if indexPath.section == 1 && indexPath.row == 0 {
      MyLoadingManager.showLoading()
      dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(2.0 * Double(NSEC_PER_SEC))), dispatch_get_main_queue(), { () -> Void in
        MyLoadingManager.hideLoading()
      })
    } else if indexPath.section == 1 && indexPath.row == 1 {
      MyAlertManager.showAlert("Sample Alert")
      
    } else if indexPath.section == 1 && indexPath.row == 2 {
      MyAlertManager.showAlert("Sample Alert", message: "With a message")
      
    } else if indexPath.section == 1 && indexPath.row == 3 {
      MyAlertManager.show2ButtonAlert("Sample 2 Button Alert", message: "With a message")
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
}