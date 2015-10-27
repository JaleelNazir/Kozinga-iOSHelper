//
//  MyTableViewController.swift
//  USAVolleyballNews
//
//  Created by Kelvin Kosbab on 9/3/15.
//  Copyright (c) 2015 Kozinga. All rights reserved.
//

import Foundation
import UIKit

class MyTableViewController : UITableViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
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