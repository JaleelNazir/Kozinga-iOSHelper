//
//  MyTabBarController.swift
//  USAVolleyballNews
//
//  Created by Kelvin Kosbab on 9/3/15.
//  Copyright (c) 2015 Kozinga. All rights reserved.
//

import Foundation
import UIKit

class MyTabBarController: UITabBarController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Bar color
    self.tabBar.barTintColor = UIColor.navigationBarColor
    
    // Text color
    self.tabBar.tintColor = UIColor.navigationBarTextColor
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