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
      viewController.delegate = delegate
      viewController.alertTitle = alertTitle
      viewController.alertMessage = alertMessage
      viewController.button1Title = buttonTitle
      viewController.button1SelectedHandler = buttonSelectedHandler
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
      viewController.delegate = delegate
      viewController.alertTitle = alertTitle
      viewController.alertMessage = alertMessage
      viewController.button1Title = button1Title
      viewController.button1SelectedHandler = button1SelectedHandler
      viewController.button2Title = button2Title
      viewController.button2SelectedHandler = button2SelectedHandler
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
      viewController.delegate = delegate
      viewController.alertTitle = alertTitle
      rootViewController.presentViewController(viewController, animated: true, completion: nil)
      return viewController
    }
    return nil
  }
  
  class func presentTextField(alertTitle: String, alertMessage: String? = nil, delegate: MyViewControllerDismissDelegate? = nil, buttonTitle: String = "Close", textFieldText: String = "", textFieldPlaceholder: String = "", textFieldEditingChangedHandler: ((String) -> Void)? = nil, buttonSelectedHandler: ((String) -> Void)? = nil) -> MyAlertController? {
    if let rootViewController = AppDelegate.rootViewController {
      let type = MyAlertType.TextFieldOneButton
      let viewController = self.getControllerFromStoryboard(type.identifier)
      viewController.type = type
      viewController.delegate = delegate
      viewController.alertTitle = alertTitle
      viewController.alertMessage = alertMessage
      viewController.button1Title = buttonTitle
      viewController.textFieldText = textFieldText
      viewController.textFieldPlaceholder = textFieldPlaceholder
      viewController.textFieldEditingChangedHandler = textFieldEditingChangedHandler
      viewController.textFieldButton1SelectedHandler = buttonSelectedHandler
      rootViewController.presentViewController(viewController, animated: true, completion: nil)
      return viewController
    }
    return nil
  }
  
  class func presentTextFieldTwoButtons(alertTitle: String, alertMessage: String? = nil, delegate: MyViewControllerDismissDelegate? = nil, button1Title: String = "Ok", button2Title: String = "Cancel", textFieldText: String = "", textFieldPlaceholder: String = "", textFieldEditingChangedHandler: ((String) -> Void)? = nil, button1SelectedHandler: ((String) -> Void)? = nil, button2SelectedHandler: ((String) -> Void)? = nil) -> MyAlertController? {
    if let rootViewController = AppDelegate.rootViewController {
      let type = MyAlertType.TextFieldTwoButton
      let viewController = self.getControllerFromStoryboard(type.identifier)
      viewController.type = type
      viewController.delegate = delegate
      viewController.alertTitle = alertTitle
      viewController.alertMessage = alertMessage
      viewController.button1Title = button1Title
      viewController.button2Title = button2Title
      viewController.textFieldText = textFieldText
      viewController.textFieldPlaceholder = textFieldPlaceholder
      viewController.textFieldEditingChangedHandler = textFieldEditingChangedHandler
      viewController.textFieldButton1SelectedHandler = button1SelectedHandler
      viewController.textFieldButton2SelectedHandler = button2SelectedHandler
      rootViewController.presentViewController(viewController, animated: true, completion: nil)
      return viewController
    }
    return nil
  }
  
  // MARK: Properties
  
  var delegate: MyViewControllerDismissDelegate? = nil
  
  enum MyAlertType {
    case Loading, OneButton, TwoButton, TextFieldOneButton, TextFieldTwoButton
    
    var string: String {
      switch self {
      case .OneButton:
        return "OneButton"
      case .TwoButton:
        return "TwoButton"
      case .TextFieldOneButton:
        return "TextFieldOneButton"
      case .TextFieldTwoButton:
        return "TextFieldTwoButton"
      case .Loading:
        return "Loading"
      }
    }
    
    var identifier: String {
      return "\(MyAlertController.identifier)\(self.string)"
    }
    
    var hasTextField: Bool {
      return self == .TextFieldOneButton || self == .TextFieldTwoButton
    }
    
    var hasButton: Bool {
      return self == .OneButton || self == .TwoButton || self == .TextFieldOneButton || self == .TextFieldTwoButton
    }
  }
  
  var type: MyAlertType!
  var alertTitle: String? = nil
  var alertMessage: String? = nil
  var button1Title: String = "Close"
  var button2Title: String = "Cancel"
  var button1SelectedHandler: (() -> Void)? = nil
  var button2SelectedHandler: (() -> Void)? = nil
  var textFieldPlaceholder: String = ""
  var textFieldText: String = ""
  var textFieldEditingChangedHandler: ((String) -> Void)? = nil
  var textFieldButton1SelectedHandler: ((String) -> Void)? = nil
  var textFieldButton2SelectedHandler: ((String) -> Void)? = nil
  
  @IBOutlet weak var blurView: UIView!
  @IBOutlet weak var contentView: UIView? = nil
  @IBOutlet weak var contentHeightConstraint: NSLayoutConstraint? = nil
  @IBOutlet weak var contentCenterYConstraint: NSLayoutConstraint? = nil
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var messageLabel: UILabel? = nil
  @IBOutlet weak var button1: UIButton? = nil
  @IBOutlet weak var button2: UIButton? = nil
  @IBOutlet weak var textField: UITextField? = nil
  
  // MARK: Lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Styling
    
    self.view.backgroundColor = UIColor.clearColor()
    self.contentView?.layer.cornerRadius = 10.0
    self.contentView?.clipsToBounds = true
    
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
    
    self.button1?.setTitle(self.button1Title, forState: .Normal)
    self.button2?.setTitle(self.button2Title, forState: .Normal)
    
    self.textField?.placeholder = self.textFieldPlaceholder
    self.textField?.text = self.textFieldText
  }
  
  override func viewDidAppear(animated: Bool) {
    super.viewDidDisappear(animated)
    
    Notification.addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification)
    Notification.addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification)
    
    self.textField?.becomeFirstResponder()
  }
  
  override func prefersStatusBarHidden() -> Bool {
    return true
  }
  
  // MARK: Actions
  
  func blurViewTapped(sender: AnyObject) {
    self.dismiss()
  }
  
  func dismiss(completionHandler: (() -> Void)? = nil) {
    self.dismissViewControllerAnimated(true) { () -> Void in
      self.delegate?.myControllerDidDismiss()
      if let handler = completionHandler {
        handler()
      }
    }
  }
  
  // MARK: Buttons
  
  @IBAction func button1Selected(sender: UIButton) {
    sender.enabled = false
    self.textField?.resignFirstResponder()
    
    if self.type.hasTextField {
      // Grab the text field text before the view is dismissed
      var finalText = ""
      if let textField = self.textField, text = textField.text {
        finalText = text
      }
      
      // Dismiss the view
      self.dismiss({ () -> Void in
        if let handler = self.textFieldButton1SelectedHandler {
          handler(finalText)
        }
      })
      
    } else {
      self.dismiss { () -> Void in
        if let handler = self.button1SelectedHandler {
          handler()
        }
      }
    }
  }
  
  @IBAction func button2Selected(sender: UIButton) {
    sender.enabled = false
    self.textField?.resignFirstResponder()
    
    if self.type.hasTextField {
      // Grab the text field text before the view is dismissed
      var finalText = ""
      if let textField = self.textField, text = textField.text {
        finalText = text
      }
      
      // Dismiss the view
      self.dismiss({ () -> Void in
        if let handler = self.textFieldButton2SelectedHandler {
          handler(finalText)
        }
      })
      
    } else {
      self.dismiss { () -> Void in
        if let handler = self.button2SelectedHandler {
          handler()
        }
      }
    }
  }
  
  // MARK: Text field
  
  @IBAction func textFieldEditingChanged(sender: UITextField) {
    if let handler = self.textFieldEditingChangedHandler {
      if let text = sender.text {
        handler(text)
      } else {
        handler("")
      }
    }
  }
  
  // MARK: Keyboard
  
  func keyboardWillShow(notification: NSNotification) {
    if let contentView = self.contentView, userInfo = notification.userInfo, durationInfo = userInfo[UIKeyboardAnimationDurationUserInfoKey], curveInfo = userInfo[UIKeyboardAnimationCurveUserInfoKey], keyboardFrameInfo = userInfo[UIKeyboardFrameEndUserInfoKey], keyboardFrame = keyboardFrameInfo.CGRectValue {
      let contentViewBottom = contentView.frame.origin.y + contentView.frame.height
      if contentViewBottom > keyboardFrame.origin.y, let constraint = self.contentCenterYConstraint {
        let duration = durationInfo.doubleValue
        let curve = UIViewKeyframeAnimationOptions(rawValue: curveInfo.unsignedIntegerValue)
        constraint.constant = keyboardFrame.origin.y - contentViewBottom - 40
        UIView.animateKeyframesWithDuration(duration, delay: 0, options: curve, animations: { () -> Void in
          self.view.layoutIfNeeded()
          }, completion: { (_) -> Void in
          // Completed
        })
      }
    }
  }
  
  func keyboardWillHide(notification: NSNotification) {
    if let constraint = self.contentCenterYConstraint, userInfo = notification.userInfo, durationInfo = userInfo[UIKeyboardAnimationDurationUserInfoKey], curveInfo = userInfo[UIKeyboardAnimationCurveUserInfoKey], keyboardFrameInfo = userInfo[UIKeyboardFrameEndUserInfoKey] {
      let duration = durationInfo.doubleValue
      let curve = UIViewKeyframeAnimationOptions(rawValue: curveInfo.unsignedIntegerValue)
      constraint.constant = 0
      UIView.animateKeyframesWithDuration(duration, delay: 0, options: curve, animations: { () -> Void in
        self.view.layoutIfNeeded()
        }, completion: { (_) -> Void in
          // Completed
      })
    }
  }
}