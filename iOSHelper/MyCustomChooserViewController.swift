//
//  MyCustomChooserViewController.swift
//  WorkoutNow
//
//  Created by Kelvin Kosbab on 9/3/15.
//  Copyright (c) 2015 Kozinga. All rights reserved.
//

import Foundation
import UIKit

protocol MyCustomChooserViewControllerDelegate {
  func myCustomChooserIndexSelected(key: String, index: Int, title: String)
  func myCustomChooserChooserCancelSelected(key: String)
}

class MyCustomChooserViewController: MyViewController {
  
  static let storyboard = "MyCustomChooser"
  static let identifier = "MyCustomChooserViewController"
  private class func getControllerFromStoryboard() -> MyCustomChooserViewController {
    let storyboard = UIStoryboard(name: MyCustomChooserViewController.storyboard, bundle: nil)
    let controller = storyboard.instantiateViewControllerWithIdentifier(MyCustomChooserViewController.identifier) as! MyCustomChooserViewController
    controller.modalPresentationStyle = UIModalPresentationStyle.OverCurrentContext
    return controller
  }
  
  class func presentMyCustomChooserViewController(presengingViewController: UIViewController, chooserObjectKey: String, chooserTitle: String, chooserItems: [String], delegate: MyCustomChooserViewControllerDelegate? = nil, isPicker: Bool = false, isCancelOption: Bool = false, backgroundTintColor: UIColor = UIColor.blackColor(), chooserBackgroundColor: UIColor = UIColor.chooserBackgroundColor, chooserButtonColor: UIColor = UIColor.whiteColor(), chooserButtonBorderColor: UIColor = UIColor.chooserBackgroundColor, chooserButtonTextColor: UIColor = UIColor.applicationPrimaryColor, chooserCancelTextColor: UIColor = UIColor.redColor(), chooserDoneText: String = "Done", chooserCancelText: String = "Cancel", chooserTitleFont: UIFont = UIFont.applicationBoldFontLarge, chooserItemFont: UIFont = UIFont.applicationFontMedium, defaultValue: String? = nil) {
    let controller = self.getControllerFromStoryboard()
    controller.delegate = delegate
    controller.chooserObjectKey = chooserObjectKey
    controller.chooserTitle = chooserTitle
    controller.chooserItems = chooserItems
    controller.isPicker = isPicker
    controller.isCancelOption = isCancelOption
    controller.backgroundTintColor = backgroundTintColor
    controller.chooserBackgroundColor = chooserBackgroundColor
    controller.chooserButtonColor = chooserButtonColor
    controller.chooserButtonBorderColor = chooserButtonBorderColor
    controller.chooserButtonTextColor = chooserButtonTextColor
    controller.chooserCancelTextColor = chooserCancelTextColor
    controller.chooserDoneText = chooserDoneText
    controller.chooserCancelText = chooserCancelText
    controller.chooserTitleFont = chooserTitleFont
    controller.chooserItemFont = chooserItemFont
    controller.defaultValue = defaultValue
    presengingViewController.presentViewController(controller, animated: false, completion: nil)
  }
  
  var delegate: MyCustomChooserViewControllerDelegate?
  
  static let NotificationClose = "MyCustomChooserViewController.Close"
  
  @IBOutlet weak var contentView: UIView!
  @IBOutlet weak var contentBackgroundView: UIView!
  @IBOutlet weak var contentBottomConstraint: NSLayoutConstraint!
  @IBOutlet weak var contentHeightConstraint: NSLayoutConstraint!
  
  @IBOutlet weak var backgroundView: UIView!
  
  // These should be set when controller is initialized before it is loaded
  var chooserObjectKey: String = ""
  var chooserTitle: String = ""
  var chooserItems: [String] = []
  
  // These are customizations properties
  var isPicker: Bool = false
  var isCancelOption = false
  var backgroundTintColor = UIColor.blackColor()
  var chooserBackgroundColor = UIColor.chooserBackgroundColor
  var chooserButtonColor = UIColor.whiteColor()
  var chooserButtonBorderColor = UIColor.chooserBackgroundColor
  var chooserButtonTextColor = UIColor.applicationPrimaryColor
  var chooserCancelTextColor = UIColor.redColor()
  var chooserDoneText: String = "Done"
  var chooserCancelText: String = "Cancel"
  var chooserTitleFont: UIFont = UIFont.applicationBoldFontLarge
  var chooserItemFont: UIFont = UIFont.applicationFontMedium
  var defaultValue: String? = nil
  
  var selectedIndex: Int? = nil
  var selectedTitle: String? = nil
  
  var contentHeight: CGFloat {
    return self.contentHeightConstraint.constant
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.backgroundView.backgroundColor = self.backgroundTintColor
    
    // Get the appropriate height of the content
    let headerHeight: CGFloat = MyChooserHeaderCell.cellHeight
    
    let rowHeight: CGFloat
    if self.isPicker {
      rowHeight = MyChooserPickerCell.cellHeight + MyChooserItemCell.cellHeight + (self.isCancelOption ? MyChooserItemCell.cellHeight : 0.0)
    } else {
      rowHeight = CGFloat(chooserItems.count + (self.isCancelOption ? 1 : 0)) * MyChooserItemCell.cellHeight
    }
    
    let footerHeight: CGFloat = MyChooserFooterCell.cellHeight
    if headerHeight + rowHeight + footerHeight <= UIScreen.mainScreen().bounds.height {
      self.contentHeightConstraint.constant = headerHeight + rowHeight + footerHeight
    } else {
      self.contentHeightConstraint.constant = UIScreen.mainScreen().bounds.height
    }
    self.view.layoutIfNeeded()
  }
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    
    Notification.addObserver(self, selector: "backgroundTapped", name: MyCustomChooserViewController.NotificationClose)
    
    self.hideContent(false)
  }
  
  override func viewDidAppear(animated: Bool) {
    super.viewDidAppear(animated)
    
    dispatch_async(GlobalMainQueue) {
      self.showContent(true)
    }
  }
  
  override func viewDidDisappear(animated: Bool) {
    super.viewDidDisappear(animated)
    
    dispatch_async(GlobalMainQueue) {
      if let index = self.selectedIndex, title = self.selectedTitle {
        self.delegate?.myCustomChooserIndexSelected(self.chooserObjectKey, index: index, title: title)
      } else {
        self.delegate?.myCustomChooserChooserCancelSelected(self.chooserObjectKey)
      }
    }
  }
  
  // MARK: Actions
  
  func backgroundTapped() {
    self.hideContent(true)
  }
  
  // MARK: Animations
  
  func showContent(animated: Bool) {
    if animated {
      self.contentBottomConstraint.constant = 0
      UIView.animateWithDuration(0.3, animations: {
        self.view.layoutIfNeeded()
        self.backgroundView.alpha = 0.3
        self.contentBackgroundView.alpha = 0.3
        }, completion: { (value: Bool) in
          let viewTapGesture = UITapGestureRecognizer(target: self, action: "backgroundTapped")
          self.backgroundView.addGestureRecognizer(viewTapGesture)
      })
    } else {
      self.contentBottomConstraint.constant = 0
      self.backgroundView.alpha = 0.3
      self.contentBackgroundView.alpha = 0.3
      self.view.layoutIfNeeded()
    }
  }
  
  func hideContent(animated: Bool) {
    if animated {
      self.contentBottomConstraint.constant = -self.contentHeight
      UIView.animateWithDuration(0.4, animations: {
        self.view.layoutIfNeeded()
        self.backgroundView.alpha = 0.0
        self.contentBackgroundView.alpha = 0.0
        }, completion: { (value: Bool) in
          self.dismissViewControllerAnimated(false, completion: nil)
      })
    } else {
      self.contentBottomConstraint.constant = -self.contentHeight
      self.backgroundView.alpha = 0.0
      self.contentBackgroundView.alpha = 0.0
      self.view.layoutIfNeeded()
    }
  }
}