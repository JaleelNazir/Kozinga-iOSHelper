//
//  MyAlertController.swift
//  iOSHelper
//
//  Created by Kelvin Kosbab on 3/18/16.
//  Copyright © 2016 Kozinga. All rights reserved.
//

import Foundation
import UIKit

class MyAlertController: MyViewController {
  
  static let storyboard = "MyAlertController"
  static let identifier = "MyAlertController"
  private class func getControllerFromStoryboard(identifier: String) -> MyAlertController {
    let storyboard = UIStoryboard(name: self.storyboard, bundle: nil)
    let controller = storyboard.instantiateViewControllerWithIdentifier(identifier) as! MyAlertController
    controller.modalPresentationStyle = .OverCurrentContext
    controller.modalTransitionStyle = .CrossDissolve
    return controller
  }
  
  class func presentOneButton(alertTitle: String, alertMessage: String? = nil, delegate: MyViewControllerDismissDelegate? = nil, buttonTitle: String = "Close", buttonSelectedHandler: (() -> Void)? = nil) -> MyAlertController? {
    if let rootViewController = AppDelegate.rootViewController {
      let type = MyAlertType.OneButton
      let viewController = self.getControllerFromStoryboard(type.identifier)
      viewController.type = type
      viewController.alertTitle = alertTitle
      viewController.alertMessage = alertMessage
      viewController.button1Title = buttonTitle
      viewController.button1SelectedHandler = buttonSelectedHandler
      viewController.delegate = delegate
      rootViewController.presentViewController(viewController, animated: true, completion: nil)
      return viewController
    }
    return nil
  }
  
  class func presentTwoButton(alertTitle: String, alertMessage: String? = nil, delegate: MyViewControllerDismissDelegate? = nil, button1Title: String = "Ok", button2Title: String = "Cancel", button1SelectedHandler: (() -> Void)? = nil, button2SelectedHandler: (() -> Void)? = nil) -> MyAlertController? {
    if let rootViewController = AppDelegate.rootViewController {
      let type = MyAlertType.TwoButton
      let viewController = self.getControllerFromStoryboard(type.identifier)
      viewController.type = type
      viewController.alertTitle = alertTitle
      viewController.alertMessage = alertMessage
      viewController.button1Title = button1Title
      viewController.button1SelectedHandler = button1SelectedHandler
      viewController.button2Title = button2Title
      viewController.button2SelectedHandler = button2SelectedHandler
      viewController.delegate = delegate
      rootViewController.presentViewController(viewController, animated: true, completion: nil)
      return viewController
    }
    return nil
  }
  
  class func presentLoading(delegate: MyViewControllerDismissDelegate? = nil, alertTitle: String? = nil) -> MyAlertController? {
    if let rootViewController = AppDelegate.rootViewController {
      let type = MyAlertType.Loading
      let viewController = self.getControllerFromStoryboard(type.identifier)
      viewController.type = type
      viewController.alertTitle = alertTitle
      viewController.delegate = delegate
      rootViewController.presentViewController(viewController, animated: true, completion: nil)
      return viewController
    }
    return nil
  }
  
  // MARK: Properties
  
  var delegate: MyViewControllerDismissDelegate? = nil
  
  enum MyAlertType {
    case Loading, OneButton, TwoButton
    
    var string: String {
      switch self {
      case .OneButton:
        return "OneButton"
      case .TwoButton:
        return "TwoButton"
      case .Loading:
        return "Loading"
      }
    }
    
    var identifier: String {
      return "\(MyAlertController.identifier)\(self.string)"
    }
  }
  
  var type: MyAlertType!
  var alertTitle: String? = nil
  var alertMessage: String? = nil
  var button1Title: String? = nil
  var button2Title: String? = nil
  var button1SelectedHandler: (() -> Void)? = nil
  var button2SelectedHandler: (() -> Void)? = nil
  
  @IBOutlet weak var blurView: UIView!
  @IBOutlet weak var contentView: UIView? = nil
  @IBOutlet weak var contentHeightConstraint: NSLayoutConstraint? = nil
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var messageLabel: UILabel? = nil
  @IBOutlet weak var button1: UIButton? = nil
  @IBOutlet weak var button2: UIButton? = nil
  
  // MARK: Lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Styling
    
    self.view.backgroundColor = UIColor.clearColor()
    
    // Content
    
    if let string = self.alertTitle {
      self.titleLabel.text = string
    } else {
      self.titleLabel.removeFromSuperview()
      self.contentHeightConstraint?.constant -= self.titleLabel.bounds.height
    }
    
    if let string = self.alertMessage, label = self.messageLabel {
      
      // Adjust the size of the alert based on the calculated message height
      let labelHeight = string.heightWithConstrainedWidth(label)
      self.contentHeightConstraint?.constant += (labelHeight - label.bounds.height) + 30
      
      // Set the message content
      label.text = string
      
    } else if let label = self.messageLabel {
      label.removeFromSuperview()
      self.contentHeightConstraint?.constant -= label.bounds.height - (self.alertTitle == nil ? 0 : 25)
    }
    
    if let string = self.button1Title, button = self.button1 {
      button.setTitle(string, forState: .Normal)
    }
    
    if let string = self.button2Title, button = self.button2 {
      button.setTitle(string, forState: .Normal)
    }
  }
  
  // MARK: Actions
  
  func blurViewTapped(sender: AnyObject) {
    self.dismiss()
  }
  
  func dismiss() {
    self.dismissViewControllerAnimated(true) { () -> Void in
      self.delegate?.myControllerDidDismiss()
    }
  }
  
  // MARK: Buttons
  
  @IBAction func button1Selected(sender: UIButton) {
    sender.enabled = false
    if let handler = self.button1SelectedHandler {
      handler()
    }
    self.dismiss()
  }
  
  @IBAction func button2Selected(sender: UIButton) {
    sender.enabled = false
    if let handler = self.button2SelectedHandler {
      handler()
    }
    self.dismiss()
  }
}