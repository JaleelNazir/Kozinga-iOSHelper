//
//  UIViewController+Util.swift
//  WorkoutNow
//
//  Created by Kelvin Kosbab on 9/3/15.
//  Copyright (c) 2015 Kozinga. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
  
  // MARK: Alert dialog
  
  func showAlertDialog(title: String, message: String, animated: Bool = true, presentViewControllerCallback: (() -> Void)? = nil, okActionCallback: (() -> Void)? = nil) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default) { (action) -> Void in
      if let handler = okActionCallback {
        handler();
      }
      })
    self.presentViewController(alert, animated: animated, completion: presentViewControllerCallback)
  }
  
}