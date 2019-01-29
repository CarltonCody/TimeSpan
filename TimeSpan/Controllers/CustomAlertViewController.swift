//
//  CustomAlertViewController.swift
//  TimeSpan
//
//  Created by Cody Carlton on 11/14/18.
//  Copyright © 2018 Cody Carlton. All rights reserved.
//

import UIKit
import Foundation

class CustomAlertViewController: UIViewController, UITextFieldDelegate {
   
    @IBOutlet weak var alertTitle: UILabel!
    
    @IBOutlet weak var alertMessage: UILabel!
    
    @IBOutlet weak var monthDateTimePicker: UIDatePicker!
    
    @IBOutlet weak var yearTextField: UITextField!
    
    @IBOutlet weak var alertCancelButton: UIButton!
    
    @IBOutlet weak var alertOkButton: UIButton!
    
    @IBOutlet weak var alertView: UIView!
    
    @IBOutlet var vcView: UIView!
    
    var customAlertDelegate:CustomAlertViewControllerDelegate!
    
    var Title:String?
    
    var Message:String?
    
    var alertDataType:AlertDataEntryType = .StartDate

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Getting title and message based on which button was pressed
        alertTitle.text = Title
        alertMessage.text = Message
        
        yearTextField.delegate = self
       
        //Listening for the keyboard
        NotificationCenter.default.addObserver(self, selector: #selector(CustomAlertViewController.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(CustomAlertViewController.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        //Customizing the textfield a little bit
        yearTextField.layer.borderColor = UIColor.init(red: 57/255, green: 67/255, blue: 183/255, alpha: 1).cgColor
        yearTextField.layer.borderWidth = 1.0
        yearTextField.layer.cornerRadius = 8.0
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setAlertViewBkg()
        setCancelButtonBkg()
        setOkButtonBkg()
        animateView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        //Showing the keyboard when the alert becomes visible
        yearTextField.becomeFirstResponder()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        vcView.layoutIfNeeded()
        view.layoutIfNeeded()
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        yearTextField.endEditing(true)
        return true
    }
    
    
    @IBAction func cancelAlert(_ sender: Any) {
        customAlertDelegate?.cancelAlertButtonPressed()
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func confirmDateTimeYear(_ sender: Any) {
        
        monthDateTimePicker.datePickerMode = .dateAndTime
        let dateTime:String = monthDateTimePicker.date.description
        
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ssZ"
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MMM d, h:mm a"
        
        var date_time = ""
        if let date = dateFormatterGet.date(from: dateTime) {
            date_time = dateFormatterPrint.string(from: date)
        }
        
        var year:String = ""
        if let yearText = yearTextField.text{
            year = yearText
        }
        
        customAlertDelegate?.okAlertButtonPressed(date: date_time, year: year, alertType: alertDataType)
        self.dismiss(animated: true, completion: nil)
    }
    
    //Moving the alert up when the keyboard shows
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0{
                self.view.frame.origin.y -= keyboardSize.height/2
            }
        }
    }
    
    //Resetting the position when the keyboard is hidden
    @objc func keyboardWillHide(notification: NSNotification) {
        self.view.frame.origin.y = 0
    }

    
    //Setting some custom traits for the views
    func setAlertViewBkg(){
        alertView.layer.cornerRadius = 15
        vcView.backgroundColor = UIColor.black.withAlphaComponent(0.4)
    }
    
    func setOkButtonBkg(){
        let orangeColor = UIColor.init(red: 242/255, green: 100/255, blue: 25/255, alpha: 1)
        alertOkButton.setTitleColor(.white, for: .normal)
        alertOkButton.backgroundColor = orangeColor
        alertOkButton.layer.cornerRadius = 15
        alertOkButton.clipsToBounds = true
        
    }
    
    func setCancelButtonBkg(){
        let blueColor = UIColor.init(red: 57/255, green: 67/255, blue: 183/255, alpha: 1)
        alertCancelButton.setTitleColor(.white, for: .normal)
        alertCancelButton.backgroundColor = blueColor
        alertCancelButton.layer.cornerRadius = 15
        alertCancelButton.clipsToBounds = true
    }
    
    func animateView() {
        alertView.alpha = 0;
        self.alertView.frame.origin.y = self.alertView.frame.origin.y + 50
        UIView.animate(withDuration: 0.4, animations: { () -> Void in
            self.alertView.alpha = 1.0;
            self.alertView.frame.origin.y = self.alertView.frame.origin.y - 50
        })
    }

}
