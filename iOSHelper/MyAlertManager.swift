//
//  MyAlertManager.swift
//  iOSHelper
//
//  Created by Kelvin Kosbab on 3/18/16.
//  Copyright © 2016 Kozinga. All rights reserved.
//

import Foundation
import UIKit

class MyLoadingManager {
  
  // This class acts as a wrapper / convenience class for loading screens.
  // It simply redirects MyAlertManager
  
  class func showLoading(title: String? = nil) {
    MyAlertManager.showLoading()
  }
  
  class func hideLoading() {
    MyAlertManager.hideLoading()
  }
}

protocol MyViewControllerDismissDelegate {
  func myControllerDidDismiss()
}

class MyAlertManager: MyViewControllerDismissDelegate {
  
  // MARK: Singleton
  
  private static let sharedInstance = MyAlertManager()
  
  private init() {}
  
  // MARK: Properties
  
  private var currentAlertController: MyAlertController? = nil
  private var alertVisible: Bool {
    if let _ = self.currentAlertController {
      return true
    }
    return false
  }
  
  // MARK: Button alerts
  
  class func showAlert(title: String, message: String? = nil, buttonTitle: String = "Close", buttonSelectedHandler: (() -> Void)? = nil) {
    if !self.sharedInstance.alertVisible {
      self.sharedInstance.currentAlertController = MyAlertController.presentOneButton(title, alertMessage: message, delegate: self.sharedInstance, buttonTitle: buttonTitle, buttonSelectedHandler: buttonSelectedHandler)
    } else {
      NSLog("Already presenting alert")
    }
  }
  
  class func show2ButtonAlert(title: String, message: String? = nil, button1Title: String = "Ok", button2Title: String = "Cancel", button1SelectedHandler: (() -> Void)? = nil, button2SelectedHandler: (() -> Void)? = nil) {
    if !self.sharedInstance.alertVisible {
      self.sharedInstance.currentAlertController = MyAlertController.presentTwoButton(title, alertMessage: message, delegate: self.sharedInstance, button1Title: button1Title, button2Title: button2Title, button1SelectedHandler: button1SelectedHandler, button2SelectedHandler: button2SelectedHandler)
    } else {
      NSLog("Already presenting alert")
    }
  }
  
  // MARK: Loading
  
  class func showLoading(title: String? = nil) {
    if let viewController = self.sharedInstance.currentAlertController where viewController.type == MyAlertController.MyAlertType.Loading {
      // Do nothing, loading is already showing
      NSLog("Already presenting loading")
      return
    }
    self.sharedInstance.currentAlertController = MyAlertController.presentLoading(self.sharedInstance, alertTitle: title)
  }
  
  class func hideLoading() {
    self.sharedInstance.hideCurrentAlert()
  }
  
  // MARK: Private methods
  
  private func hideCurrentAlert() {
    self.currentAlertController?.dismiss()
  }
  
  // MARK: MyViewControllerDismissDelegate
  
  func myControllerDidDismiss() {
    self.currentAlertController = nil
  }
}