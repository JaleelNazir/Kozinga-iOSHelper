//
//  MyCustomChooserTableViewController.swift
//  WorkoutNow
//
//  Created by Kelvin Kosbab on 9/4/15.
//  Copyright (c) 2015 Kozinga. All rights reserved.
//

import Foundation
import UIKit

class MyChooserHeaderCell: UITableViewCell {
  static let cellHeight: CGFloat = 55
  static let identifier: String = "MyChooserHeaderCell"
  @IBOutlet weak var accentView: UIView!
  @IBOutlet weak var titleLabel: UILabel!
}

class MyChooserItemCell: UITableViewCell {
  static let cellHeight: CGFloat = 39
  static let identifier: String = "MyChooserItemCell"
  @IBOutlet weak var accentView: UIView!
  @IBOutlet weak var itemLabel: UILabel!
  
  override func setSelected(selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    if selected {
      self.accentView.backgroundColor = UIColor.chooserHighlightColor
      UIView.animateWithDuration(0.2, animations: {
        self.accentView.backgroundColor = UIColor.whiteColor()
        }, completion: { (value: Bool) in
      })
    } else {
      self.accentView.backgroundColor = UIColor.whiteColor()
    }
  }
}

class MyChooserPickerCell: UITableViewCell {
  static let cellHeight: CGFloat = 170
  static let identifier: String = "MyChooserPickerCell"
  @IBOutlet weak var accentView: UIView!
  @IBOutlet weak var pickerView: UIPickerView!
}

class MyChooserFooterCell: UITableViewCell {
  static let cellHeight: CGFloat = 8
  static let identifier: String = "MyChooserFooterCell"
}

class MyCustomChooserTableViewController: MyTableViewController, UIPickerViewDataSource, UIPickerViewDelegate {
  
  // These should be set in the ModuleViewController before controller is loaded
  var chooserObjectKey: String = ""
  var chooserTitle: String = ""
  var items: [String] = []
  
  // These are customizations properties
  var isPicker: Bool = false
  var isCancelOption: Bool = false
  var chooserBackgroundColor: UIColor = UIColor.chooserBackgroundColor
  var chooserButtonColor: UIColor = UIColor.whiteColor()
  var chooserButtonBorderColor: UIColor = UIColor.chooserBackgroundColor
  var chooserButtonTextColor: UIColor = UIColor.applicationPrimaryColor
  var chooserCancelTextColor: UIColor = UIColor.redColor()
  var chooserDoneText: String = "Done"
  var chooserCancelText: String = "Cancel"
  var chooserTitleFont: UIFont = UIFont.applicationBoldFontLarge
  var chooserItemFont: UIFont = UIFont.applicationFontMedium
  var defaultValue: String? = nil
  
  var selectedIndex: Int = 0
  var selectedTitle: String = ""
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.tableView.backgroundColor = UIColor.clearColor()
    
    self.loadData()
  }
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
  }
  
  // MARK: Actions
  
  private func loadData() {
    dispatch_async(GlobalMainQueue) {
      if let parent = self.parentViewController as? MyCustomChooserViewController {
        self.chooserObjectKey = parent.chooserObjectKey
        self.chooserTitle = parent.chooserTitle
        self.items = parent.chooserItems
        
        self.isPicker = parent.isPicker
        self.isCancelOption = parent.isCancelOption
        self.chooserBackgroundColor = parent.chooserBackgroundColor
        self.chooserButtonColor = parent.chooserButtonColor
        self.chooserButtonBorderColor = parent.chooserButtonBorderColor
        self.chooserButtonTextColor = parent.chooserButtonTextColor
        self.chooserCancelTextColor = parent.chooserCancelTextColor
        self.chooserDoneText = parent.chooserDoneText
        self.chooserCancelText = parent.chooserCancelText
        self.chooserTitleFont = parent.chooserTitleFont
        self.chooserItemFont = parent.chooserItemFont
        self.defaultValue = parent.defaultValue
      }
      self.tableView.reloadData()
    }
  }
  
  // MARK: Table view
  
  override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if self.isPicker { // Picker
      if self.isCancelOption {
        return 3
      }
      return 2
    }
    
    // Chooser
    return self.items.count + (self.isCancelOption ? 1 : 0)
  }
  
  override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return MyChooserHeaderCell.cellHeight
  }
  
  override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
    return MyChooserFooterCell.cellHeight
  }
  
  override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
    if self.isPicker && indexPath.row == 0 {
      return MyChooserPickerCell.cellHeight
    }
    return MyChooserItemCell.cellHeight
  }
  
  override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    let cell = tableView.dequeueReusableCellWithIdentifier(MyChooserHeaderCell.identifier) as! MyChooserHeaderCell
    cell.contentView.backgroundColor = self.chooserBackgroundColor
    cell.accentView.backgroundColor = self.chooserButtonColor
    cell.accentView.layer.borderWidth = 1
    cell.accentView.layer.borderColor = self.chooserButtonBorderColor.CGColor
    cell.titleLabel.text = self.chooserTitle
    cell.titleLabel.textColor = self.chooserButtonTextColor
    cell.titleLabel.font = self.chooserTitleFont
    return cell.contentView
  }
  
  override func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
    let cell = tableView.dequeueReusableCellWithIdentifier(MyChooserFooterCell.identifier) as! MyChooserFooterCell
    cell.contentView.backgroundColor = self.chooserBackgroundColor
    return cell.contentView
  }
  
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    if self.isPicker { // Picker
      if indexPath.row == 0 {
        let cell = tableView.dequeueReusableCellWithIdentifier(MyChooserPickerCell.identifier, forIndexPath: indexPath) as! MyChooserPickerCell
        cell.contentView.backgroundColor = self.chooserBackgroundColor
        cell.accentView.backgroundColor = self.chooserButtonColor
        cell.pickerView.delegate = self
        cell.pickerView.dataSource = self
        
        if let value = self.defaultValue, index = self.items.indexOf(value) {
          self.selectedIndex = index
          self.selectedTitle = value
          cell.pickerView.selectRow(self.selectedIndex, inComponent: 0, animated: false)
        } else if self.items.count > 0 {
          self.selectedIndex = 0
          self.selectedTitle = self.items[0]
          cell.pickerView.selectRow(self.selectedIndex, inComponent: 0, animated: false)
        }
        
        return cell
      }
      let cell = tableView.dequeueReusableCellWithIdentifier(MyChooserItemCell.identifier, forIndexPath: indexPath) as! MyChooserItemCell
      cell.contentView.backgroundColor = self.chooserBackgroundColor
      cell.accentView.backgroundColor = self.chooserButtonColor
      cell.accentView.layer.borderWidth = 1
      cell.accentView.layer.borderColor = self.chooserButtonBorderColor.CGColor
      cell.itemLabel.font = self.chooserItemFont
      if indexPath.row == 1 {
        cell.itemLabel.text = self.chooserDoneText
        cell.itemLabel.textColor = self.chooserButtonTextColor
      } else {
        cell.itemLabel.text = self.chooserCancelText
        cell.itemLabel.textColor = self.chooserCancelTextColor
      }
      return cell
    }
    
    // Chooser
    let cell = tableView.dequeueReusableCellWithIdentifier(MyChooserItemCell.identifier, forIndexPath: indexPath) as! MyChooserItemCell
    cell.contentView.backgroundColor = self.chooserBackgroundColor
    cell.accentView.backgroundColor = self.chooserButtonColor
    cell.accentView.layer.borderWidth = 1
    cell.accentView.layer.borderColor = self.chooserButtonBorderColor.CGColor
    cell.itemLabel.font = self.chooserItemFont
    if indexPath.row == self.items.count {
      cell.itemLabel.text = self.chooserCancelText
      cell.itemLabel.textColor = self.chooserCancelTextColor
    } else {
      cell.itemLabel.text = self.items[indexPath.row]
      cell.itemLabel.textColor = self.chooserButtonTextColor
    }
    return cell
  }
  
  override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    if self.isPicker { // Picker
      if indexPath.row == 1, let parent = self.parentViewController as? MyCustomChooserViewController {
        // Done was chosen
        parent.selectedIndex = self.selectedIndex
        parent.selectedTitle = self.selectedTitle
        Notification.postNotification(MyCustomChooserViewController.NotificationClose)
      } else if indexPath.row == 2 {
        // Cancel was chosen
        Notification.postNotification(MyCustomChooserViewController.NotificationClose)
      }
    } else {
      // Chooser
      if indexPath.row < self.items.count, let parent = self.parentViewController as? MyCustomChooserViewController {
        // An item was chosen
        parent.selectedIndex = indexPath.row
        parent.selectedTitle = self.items[indexPath.row]
        Notification.postNotification(MyCustomChooserViewController.NotificationClose)
      } else {
        // Cancel was chosen
        Notification.postNotification(MyCustomChooserViewController.NotificationClose)
      }
    }
  }
  
  // MARK: Picker view
  
  func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
    return 1
  }
  
  func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    return self.items.count
  }
  
  func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    self.selectedIndex = row
    self.selectedTitle = self.items[self.selectedIndex]
  }
  
  func pickerView(pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusingView view: UIView?) -> UIView {
    let titleLabel: UILabel
    if let label = view as? UILabel {
      titleLabel = label
    } else {
      titleLabel = UILabel()
    }
    titleLabel.font = self.chooserItemFont
    titleLabel.numberOfLines = 1
    titleLabel.textAlignment = NSTextAlignment.Center
    titleLabel.text = self.items[row]
    return titleLabel
  }
}