//
//  LoadingViewController.swift
//  WorkoutNow
//
//  Created by Kelvin Kosbab on 9/13/15.
//  Copyright (c) 2015 Kozinga. All rights reserved.
//

import Foundation
import UIKit

class LoadingViewController: MyViewController {
  
  private static let storyboard = "Loading"
  private static let identifier = "LoadingViewController"
  private class func getControllerFromStoryboard() -> LoadingViewController {
    let storyboard = UIStoryboard(name: LoadingViewController.storyboard, bundle: nil)
    let controller = storyboard.instantiateViewControllerWithIdentifier(LoadingViewController.identifier) as! LoadingViewController
    controller.modalPresentationStyle = UIModalPresentationStyle.OverCurrentContext
    return controller
  }
  
  class func showLoading(presentingViewController: UIViewController, loadingText: String = "Loading...", completion: (() -> Void)? = nil) -> LoadingViewController {
    let controller = self.getControllerFromStoryboard()
    controller.loadingText = loadingText
    presentingViewController.presentViewController(controller, animated: false, completion: completion)
    return controller
  }
  
  class func getController(loadingText: String = "Loading...") -> LoadingViewController {
    let controller = self.getControllerFromStoryboard()
    controller.loadingText = loadingText
    return controller
  }
  
  class func dismissLoading() {
    Notification.postNotification(LoadingViewController.DismissLoading)
  }
  
  static let DismissLoading: String = "LoadingViewController.Dismiss"
  
  @IBOutlet weak var backgroundView: UIView!
  @IBOutlet weak var contentView: UIView!
  @IBOutlet weak var loadingLabel: UILabel!
  @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
  @IBOutlet weak var contentYCenterConstraint: NSLayoutConstraint!
  
  var loadingText: String = "Loading..."
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.view.backgroundColor = UIColor.clearColor()
    self.backgroundView.backgroundColor = UIColor.blackColor()
    
    self.hideContent(false)
    
    self.loadingLabel.textColor = UIColor.applicationPrimaryColor
    self.loadingLabel.text = self.loadingText
    
    self.activityIndicator.tintColor = UIColor.applicationPrimaryColor
  }
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    
    Notification.addObserver(self, selector: "dismiss", name: LoadingViewController.DismissLoading)
  }
  
  override func viewDidAppear(animated: Bool) {
    super.viewDidAppear(animated)
    
    dispatch_async(GlobalMainQueue) {
      self.showContent(true)
    }
  }
  
  // MARK: Actions
  
  func dismiss() {
    self.hideContent(true)
  }
  
  func dismiss(completion: (() -> Void)? = nil) {
    self.hideContent(true, completion: completion)
  }
  
  // MARK: Animations
  
  func showContent(animated: Bool) {
    self.contentYCenterConstraint.constant = 0
    if animated {
      UIView.animateWithDuration(0.2, animations: {
        self.view.layoutIfNeeded()
        self.backgroundView.alpha = 0.7
        self.contentView.alpha = 1.0
        }, completion: { (value: Bool) in
      })
    } else {
      self.backgroundView.alpha = 0.3
      self.contentView.alpha = 1
      self.view.layoutIfNeeded()
    }
  }
  
  func hideContent(animated: Bool, completion: (() -> Void)? = nil) {
    self.contentYCenterConstraint.constant = -(UIScreen.mainScreen().bounds.height + (self.contentView.bounds.height / 2))
    if animated {
      UIView.animateWithDuration(0.2, animations: {
        self.view.layoutIfNeeded()
        self.backgroundView.alpha = 0.0
        self.contentView.alpha = 0.0
        }, completion: { (value: Bool) in
          self.dismissViewControllerAnimated(false, completion: completion)
      })
    } else {
      self.backgroundView.alpha = 0.0
      self.contentView.alpha = 0.0
      self.view.layoutIfNeeded()
      if let handler = completion {
        handler()
      }
    }
  }
}