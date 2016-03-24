//
//  MyCustomChooserViewController.swift
//  WorkoutNow
//
//  Created by Kelvin Kosbab on 9/3/15.
//  Copyright (c) 2015 Kozinga. All rights reserved.
//

import Foundation
import UIKit

class MCCItem: NSObject {
  var title: String = ""
  var callback: (() -> Void)? = nil
  init(title: String, callback: (() -> Void)? = nil) {
    self.title = title
    self.callback = callback
  }
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
  
  class func presentMyCustomChooserViewController(presengingViewController: UIViewController, chooserTitle: String, chooserItems: [MCCItem], isPicker: Bool = false, cancelItem: MCCItem? = nil, backgroundTintColor: UIColor = UIColor.blackColor(), chooserBackgroundColor: UIColor = UIColor.chooserBackgroundColor, chooserButtonColor: UIColor = UIColor.whiteColor(), chooserButtonBorderColor: UIColor = UIColor.chooserBackgroundColor, chooserButtonTextColor: UIColor = UIColor.applicationPrimaryColor, chooserCancelTextColor: UIColor = UIColor.redColor(), chooserDoneText: String = "Done", chooserTitleFont: UIFont = UIFont.applicationBoldFontLarge, chooserItemFont: UIFont = UIFont.applicationFontMedium, defaultValue: MCCItem? = nil, statusBarStyle: UIStatusBarStyle = .Default) {
    let controller = self.getControllerFromStoryboard()
    controller.statusBarStyle = statusBarStyle
    controller.chooserTitle = chooserTitle
    controller.chooserItems = chooserItems
    controller.isPicker = isPicker
    controller.cancelItem = cancelItem
    controller.backgroundTintColor = backgroundTintColor
    controller.chooserBackgroundColor = chooserBackgroundColor
    controller.chooserButtonColor = chooserButtonColor
    controller.chooserButtonBorderColor = chooserButtonBorderColor
    controller.chooserButtonTextColor = chooserButtonTextColor
    controller.chooserCancelTextColor = chooserCancelTextColor
    controller.chooserDoneText = chooserDoneText
    controller.chooserTitleFont = chooserTitleFont
    controller.chooserItemFont = chooserItemFont
    controller.defaultValue = defaultValue
    
    presengingViewController.presentViewController(controller, animated: false, completion: nil)
  }

  static let NotificationClose = "MyCustomChooserViewController.Close"
  
  @IBOutlet weak var contentView: UIView!
  @IBOutlet weak var contentBackgroundView: UIView!
  @IBOutlet weak var contentBottomConstraint: NSLayoutConstraint!
  @IBOutlet weak var contentHeightConstraint: NSLayoutConstraint!
  
  @IBOutlet weak var backgroundView: UIView!
  
  // These should be set when controller is initialized before it is loaded
  var chooserTitle: String = ""
  var chooserItems: [MCCItem] = []
  
  // These are customizations properties
  var statusBarStyle: UIStatusBarStyle = .Default
  var isPicker: Bool = false
  var backgroundTintColor = UIColor.blackColor()
  var chooserBackgroundColor = UIColor.chooserBackgroundColor
  var chooserButtonColor = UIColor.whiteColor()
  var chooserButtonBorderColor = UIColor.chooserBackgroundColor
  var chooserButtonTextColor = UIColor.applicationPrimaryColor
  var chooserCancelTextColor = UIColor.redColor()
  var chooserDoneText: String = "Done"
  var chooserTitleFont: UIFont = UIFont.applicationBoldFontLarge
  var chooserItemFont: UIFont = UIFont.applicationFontMedium
  var defaultValue: MCCItem? = nil
  var cancelItem: MCCItem? = nil
  var isCancelOption: Bool {
    return self.cancelItem != nil
  }
  
  var selectedIndex: Int? = nil
  
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
    
    Notification.addObserver(self, selector: #selector(self.backgroundTapped), name: MyCustomChooserViewController.NotificationClose)
    
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
      if let index = self.selectedIndex, callback = self.chooserItems[index].callback {
        callback()
      } else if let cancel = self.cancelItem, callback = cancel.callback {
        callback()
      }
    }
  }
  
  override func preferredStatusBarStyle() -> UIStatusBarStyle {
    return self.statusBarStyle
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
          let viewTapGesture = UITapGestureRecognizer(target: self, action: #selector(self.backgroundTapped))
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