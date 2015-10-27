//
//  UIView+Util.swift
//  WorkoutNow
//
//  Created by Kelvin Kosbab on 9/15/15.
//  Copyright (c) 2015 Kozinga. All rights reserved.
//

import Foundation
import UIKit
import QuartzCore

extension UIView {
  
  // MARK: Shadows
  
  func applyPlainShadow() {
    let layer = self.layer
    layer.shadowColor = UIColor.blackColor().CGColor
    layer.shadowOffset = CGSize(width: 0, height: 10)
    layer.shadowOpacity = 0.4
    layer.shadowRadius = 5
  }
  
  func applyCurvedShadow() {
    let size = self.bounds.size
    let width = size.width
    let height = size.height
    let depth = CGFloat(11.0)
    let lessDepth = 0.8 * depth
    let curvyness = CGFloat(5)
    let radius = CGFloat(1)
    
    let path = UIBezierPath()
    
    // top left
    path.moveToPoint(CGPoint(x: radius, y: height))
    
    // top right
    path.addLineToPoint(CGPoint(x: width - 2*radius, y: height))
    
    // bottom right + a little extra
    path.addLineToPoint(CGPoint(x: width - 2*radius, y: height + depth))
    
    // path to bottom left via curve
    path.addCurveToPoint(CGPoint(x: radius, y: height + depth),
      controlPoint1: CGPoint(x: width - curvyness, y: height + lessDepth - curvyness),
      controlPoint2: CGPoint(x: curvyness, y: height + lessDepth - curvyness))
    
    let layer = self.layer
    layer.shadowPath = path.CGPath
    layer.shadowColor = UIColor.blackColor().CGColor
    layer.shadowOpacity = 0.3
    layer.shadowRadius = radius
    layer.shadowOffset = CGSize(width: 0, height: -3)
  }
  
  func applyHoverShadow() {
    let size = self.bounds.size
    let width = size.width
    let height = size.height
    
    let ovalRect = CGRect(x: 5, y: height + 5, width: width - 10, height: 15)
    let path = UIBezierPath(roundedRect: ovalRect, cornerRadius: 10)
    
    let layer = self.layer
    layer.shadowPath = path.CGPath
    layer.shadowColor = UIColor.blackColor().CGColor
    layer.shadowOpacity = 0.2
    layer.shadowRadius = 5
    layer.shadowOffset = CGSize(width: 0, height: 0)
  }
  
  // MARK: Corners
  
  func applyRoundedCorners(radius: CGFloat) {
    self.layer.cornerRadius = radius
    self.clipsToBounds = true
  }
}