//
//  MyNavigationController.swift
//  USAVolleyballNews
//
//  Created by Kelvin Kosbab on 9/3/15.
//  Copyright (c) 2015 Kozinga. All rights reserved.
//

import Foundation
import UIKit

class MyNavigationController: UINavigationController {
  
  static let NavigationBarTapped = "NavigationBarTapped"
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.navigationBar.translucent = false
    
    // Bar color
    self.navigationBar.barTintColor = UIColor.navigationBarColor
    self.navigationBar.tintColor = UIColor.navigationBarTextColor
    
    // Tab bar text color
    self.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.navigationBarTextColor, NSFontAttributeName: UIFont.applicationFontMedium]
  }
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
  }
  
  override func viewDidDisappear(animated: Bool) {
    super.viewDidDisappear(animated)
    
    Notification.removeObserver(self)
  }
  
  override func preferredStatusBarStyle() -> UIStatusBarStyle {
    return UIStatusBarStyle.LightContent
  }
}