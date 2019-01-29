//
//  CustomAlertViewControllerDelegate.swift
//  TimeSpan
//
//  Created by Cody Carlton on 11/19/18.
//  Copyright © 2018 Cody Carlton. All rights reserved.
//

protocol CustomAlertViewControllerDelegate:class {
    
    func cancelAlertButtonPressed()
    func okAlertButtonPressed(date:String, year:String, alertType:AlertDataEntryType)
    
}
