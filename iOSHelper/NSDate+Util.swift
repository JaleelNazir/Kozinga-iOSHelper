//
//  NSDate+commonFormats.swift
//  KelvinAndrew
//
//  Created by Kelvin Kosbab on 5/12/15.
//  Copyright (c) 2015 Kozinga. All rights reserved.
//

import Foundation

extension NSDate {
  
  // MARK: Date formats
  
  var applicationDateFormat: String {
    let dateFormatter = NSDateFormatter()
    dateFormatter.dateFormat = "EEEE MMM d, YYYY"
    return dateFormatter.stringFromDate(self)
  }
  
  var applicationDateFormatNoDayOfWeek: String {
    let dateFormatter = NSDateFormatter()
    dateFormatter.dateFormat = "MMM d, YYYY"
    return dateFormatter.stringFromDate(self)
  }
  
  var applicationTimeFormat: String {
    let dateFormatter = NSDateFormatter()
    dateFormatter.dateFormat = "h:mm a"
    return dateFormatter.stringFromDate(self)
  }
  
  var applicationDateTimeFormat: String {
    let dateFormatter = NSDateFormatter()
    dateFormatter.dateFormat = "MMM d, YYYY h:mm a"
    return dateFormatter.stringFromDate(self)
  }
  
  class func parseServerDateString(dateString: String) -> NSDate? {
    let dateFormatter = NSDateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
    return dateFormatter.dateFromString(dateString)
  }
  
  class func dateToServerDateString(date: NSDate) -> String {
    let dateFormatter = NSDateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
    return dateFormatter.stringFromDate(date)
  }
  
  // MARK: Duration
  
  class public func yearsBetweenDates(fromDate: NSDate, toDate: NSDate) -> Int {
    let cal = NSCalendar.currentCalendar()
    let components = cal.components(.Year, fromDate: fromDate, toDate: toDate, options: [])
    return components.year
  }
  
  class public func monthsBetweenDates(fromDate: NSDate, toDate: NSDate) -> Int {
    let cal = NSCalendar.currentCalendar()
    let components = cal.components(.Month, fromDate: fromDate, toDate: toDate, options: [])
    return components.month
  }
  
  class public func daysBetweenDates(fromDate: NSDate, toDate: NSDate) -> Int {
    let cal = NSCalendar.currentCalendar()
    let components = cal.components(.Day, fromDate: fromDate, toDate: toDate, options: [])
    return components.day
  }
  
  class public func hoursBetweenDates(fromDate: NSDate, toDate: NSDate) -> Int {
    let cal = NSCalendar.currentCalendar()
    let components = cal.components(.Hour, fromDate: fromDate, toDate: toDate, options: [])
    return components.hour
  }
  
  class public func minutesBetweenDates(fromDate: NSDate, toDate: NSDate) -> Int {
    let cal = NSCalendar.currentCalendar()
    let components = cal.components(.Minute, fromDate: fromDate, toDate: toDate, options: [])
    return components.minute
  }
  
  class public func secondsBetweenDates(fromDate: NSDate, toDate: NSDate) -> Int {
    let cal = NSCalendar.currentCalendar()
    let components = cal.components(.Second, fromDate: fromDate, toDate: toDate, options: [])
    return components.second
  }
  
  class public func nanosecondsBetweenDates(fromDate: NSDate, toDate: NSDate) -> Int {
    let cal = NSCalendar.currentCalendar()
    let components = cal.components(.Nanosecond, fromDate: fromDate, toDate: toDate, options: [])
    return components.nanosecond
  }
  
  // MARK: Comparison
  
  func compareIsGreaterThanDate(dateToCompare: NSDate) -> Bool {
    return self.compare(dateToCompare) == NSComparisonResult.OrderedDescending
  }
  
  func compareIsLessThanDate(dateToCompare: NSDate) -> Bool {
    return self.compare(dateToCompare) == NSComparisonResult.OrderedAscending
  }
  
  func compareIsEqualToDate(dateToCompare: NSDate) -> Bool {
    return self.compare(dateToCompare) == NSComparisonResult.OrderedSame
  }
  
  // MARK: Adding intervals
  
  func addHours(hours: Int) -> NSDate? {
    let hourComponent = NSDateComponents()
    hourComponent.hour = hours;
    let theCalendar = NSCalendar.currentCalendar()
    return theCalendar.dateByAddingComponents(hourComponent, toDate: self, options: [])
  }
  
  func addDays(days: Int) -> NSDate? {
    let dayComponent = NSDateComponents()
    dayComponent.day = days;
    let theCalendar = NSCalendar.currentCalendar()
    return theCalendar.dateByAddingComponents(dayComponent, toDate: self, options: [])
  }
  
  func addMonths(months: Int) -> NSDate? {
    let monthComponent = NSDateComponents()
    monthComponent.month = months;
    let theCalendar = NSCalendar.currentCalendar()
    return theCalendar.dateByAddingComponents(monthComponent, toDate: self, options: [])
  }
  
  // MARK: Specific values
  
  var year: Int {
    let calendar = NSCalendar.currentCalendar()
    let components = calendar.components(.Year, fromDate: self)
    return components.year;
  }
  
  var month: Int {
    let calendar = NSCalendar.currentCalendar()
    let components = calendar.components(.Month, fromDate: self)
    return components.month;
  }
  
  var day: Int {
    let calendar = NSCalendar.currentCalendar()
    let components = calendar.components(.Day, fromDate: self)
    return components.day;
  }
  
  var hour: Int {
    let calendar = NSCalendar.currentCalendar()
    let components = calendar.components(.Hour, fromDate: self)
    return components.hour;
  }
  
  var minute: Int {
    let calendar = NSCalendar.currentCalendar()
    let components = calendar.components(.Minute, fromDate: self)
    return components.minute;
  }
  
  var second: Int {
    let calendar = NSCalendar.currentCalendar()
    let components = calendar.components(.Second, fromDate: self)
    return components.second;
  }
  
  var uniqueId: Int {
    return Int(self.timeIntervalSince1970)
  }
}