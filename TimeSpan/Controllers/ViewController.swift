//
//  ViewController.swift
//  TimeSpan
//
//  Created by Cody Carlton on 11/13/18.
//  Copyright © 2018 Cody Carlton. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var startDate:String = ""
    var startYear:String = ""
    
    var endDate:String = ""
    var endYear:String = ""
    
    var alertDataType:AlertDataEntryType = .StartDate

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Setting views
        view.addSubview(topView)
        view.addSubview(middleView)
        view.addSubview(bottomView)
        
        //Setting constraints on the views
        setTopViewConstraints()
        setMiddleViewConstraints()
        setBottomViewConstraints()
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    
    //Top view (Container of calculated time label)
    let topView:UIView = {
        let topBackgroundView = UIView()
        topBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        let blueColor = UIColor.init(red: 57/255, green: 67/255, blue: 183/255, alpha: 1)
        topBackgroundView.backgroundColor = blueColor
        return topBackgroundView
    }()//topView
    
    func setTopViewConstraints(){
        
        topView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.35).isActive = true
        topView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        topView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        topView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        topView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width).isActive = true
        
        topView.addSubview(calculatedTimeLabel)
        setCalculatedTimeLabelConstraints()
        
    }//setupTopView
    
    //Calculated Time label (Child of TopView)
    let calculatedTimeLabel:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.textAlignment = .center
        label.text = "Calculated time"
        label.font = label.font.withSize(30)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 5
        label.sizeToFit()
        return label
    }()//CalculatedTimeLabel
    
    func setCalculatedTimeLabelConstraints(){
        
        calculatedTimeLabel.heightAnchor.constraint(equalTo: topView.heightAnchor, multiplier: 1).isActive = true
        calculatedTimeLabel.widthAnchor.constraint(equalTo: topView.widthAnchor, constant: -15).isActive = true
        calculatedTimeLabel.centerXAnchor.constraint(equalTo: topView.centerXAnchor, constant: 0).isActive = true
        calculatedTimeLabel.centerYAnchor.constraint(equalTo: topView.centerYAnchor, constant: 0).isActive = true
    }//setupCalculatedTimeLabel
    
    
    //Middle view (Container of set begin date and set end date)
    let middleView:UIView = {
        let midView = UIView()
        midView.translatesAutoresizingMaskIntoConstraints = false
        return midView
    }()//middleView
    
    func setMiddleViewConstraints(){
        middleView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.35).isActive = true
        middleView.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: 0).isActive = true
        middleView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        middleView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        middleView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width).isActive = true
        
        middleView.addSubview(startDateButton)
        setStartDateButtonConstraints()
        
        view.addSubview(endDateButton)
        setEndDateButtonConstraints()
        
    }
    
    let startDateButton:UIButton = {
       let startButton = UIButton()
        startButton.translatesAutoresizingMaskIntoConstraints = false
        let blueColor = UIColor.init(red: 57/255, green: 67/255, blue: 183/255, alpha: 1)
        startButton.setTitle("Set begin date", for: .normal)
        startButton.setTitleColor(blueColor, for: .normal)
        startButton.setTitleColor(.white, for: .highlighted)
        startButton.titleLabel?.adjustsFontSizeToFitWidth = true
        startButton.setBackgroundColor(blueColor, for: .highlighted)
        startButton.titleEdgeInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        startButton.backgroundColor = .clear
        startButton.layer.cornerRadius = 8
        startButton.layer.borderWidth = 1
        startButton.layer.borderColor = blueColor.cgColor
        startButton.clipsToBounds = true
        startButton.addTarget(self, action: #selector(startDateButtonPressed), for: .touchUpInside)
        return startButton
    }()//startDateButton
    
    func setStartDateButtonConstraints(){
        startDateButton.topAnchor.constraint(equalTo: middleView.topAnchor, constant: 25).isActive = true
        startDateButton.heightAnchor.constraint(equalToConstant: 56).isActive = true
        startDateButton.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 40).isActive = true
        startDateButton.centerXAnchor.constraint(equalTo: middleView.centerXAnchor, constant: 0).isActive = true
    }//setStartDateButtonConstraints
    
    //Start date button pressed
    @objc func startDateButtonPressed(sender: UIButton!){
        alertDataType = .StartDate
        showAlertDateEntry(alertType: alertDataType)
    }//startDateButtonPressed
    
    
    let endDateButton:UIButton = {
        let endButton = UIButton()
        endButton.translatesAutoresizingMaskIntoConstraints = false
        let blueColor = UIColor.init(red: 57/255, green: 67/255, blue: 183/255, alpha: 1)
        endButton.setTitle("Set end date", for: .normal)
        endButton.setTitleColor(blueColor, for: .normal)
        endButton.setTitleColor(.white, for: .highlighted)
        endButton.titleLabel?.adjustsFontSizeToFitWidth = true
        endButton.setBackgroundColor(blueColor, for: .highlighted)
        endButton.titleEdgeInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        endButton.backgroundColor = .clear
        endButton.layer.cornerRadius = 8
        endButton.layer.borderWidth = 1
        endButton.layer.borderColor = blueColor.cgColor
        endButton.clipsToBounds = true
        endButton.addTarget(self, action: #selector(endDateButtonPressed), for: .touchUpInside)
        return endButton
    }()//endDateButton
    
    //End button pressed
    @objc func endDateButtonPressed(sender: UIButton!){
        alertDataType = .EndDate
        showAlertDateEntry(alertType: alertDataType)
    }//endDateButtonPressed
    
    func setEndDateButtonConstraints(){
        endDateButton.topAnchor.constraint(equalTo: startDateButton.bottomAnchor, constant: 35).isActive = true
        endDateButton.heightAnchor.constraint(equalToConstant: 56).isActive = true
        endDateButton.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 40).isActive = true
        endDateButton.centerXAnchor.constraint(equalTo: middleView.centerXAnchor, constant: 0).isActive = true
    }//setEndDateButtonConstraints
    
    
    //Bottom view (Container of calculate button and clear button)
    let bottomView:UIView = {
        let botView = UIView()
        botView.translatesAutoresizingMaskIntoConstraints = false
        return botView
    }()//bottomView
    
    func setBottomViewConstraints(){
        bottomView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.35).isActive = true
        bottomView.topAnchor.constraint(equalTo: middleView.bottomAnchor, constant: 0).isActive = true
        bottomView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        bottomView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        bottomView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width).isActive = true
        
        bottomView.addSubview(calculateButton)
        setCalculateButtonConstraints()
        
        bottomView.addSubview(clearButton)
        setClearButtonConstraints()
    }//setBottomViewConstraints
    
    
    let calculateButton:UIButton = {
        let calButton = UIButton()
        calButton.translatesAutoresizingMaskIntoConstraints = false
        let orangeColor = UIColor.init(red: 242/255, green: 100/255, blue: 25/255, alpha: 1)
        calButton.setTitle("Calculate", for: .normal)
        calButton.setTitleColor(.white, for: .normal)
        calButton.setTitleColor(orangeColor, for: .highlighted)
        calButton.setBackgroundColor(.white, for: .highlighted)
        calButton.backgroundColor = orangeColor
        calButton.layer.cornerRadius = 25
        calButton.clipsToBounds = true
        calButton.addTarget(self, action: #selector(calculateButtonPressed), for: .touchUpInside)
        return calButton
    }()//calculateButton
    
    //Calculate button pressed
    @objc func calculateButtonPressed(sender: UIButton!){
        
        calcTimeDiff(startDate: startDate, endDate: endDate, startYear: startYear, endYear: endYear)
        
    }//calculateButtonPressed
    
    func setCalculateButtonConstraints(){
        calculateButton.topAnchor.constraint(equalTo: bottomView.topAnchor, constant: 25).isActive = true
        calculateButton.heightAnchor.constraint(equalToConstant: 56).isActive = true
        calculateButton.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 40).isActive = true
        calculateButton.centerXAnchor.constraint(equalTo: bottomView.centerXAnchor, constant: 0).isActive = true
        
    }//setCalculateButtonConstraints
    
    
    let clearButton:UIButton = {
        let clButton = UIButton()
        clButton.translatesAutoresizingMaskIntoConstraints = false
        let blueColor = UIColor.init(red: 57/255, green: 67/255, blue: 183/255, alpha: 1)
        clButton.setTitle("Clear", for: .normal)
        clButton.setTitleColor(blueColor, for: .normal)
        clButton.setTitleColor(.white, for: .highlighted)
        clButton.setBackgroundColor(blueColor, for: .highlighted)
        clButton.backgroundColor = .white
        clButton.layer.cornerRadius = 25
        clButton.clipsToBounds = true
        clButton.addTarget(self, action: #selector(clearButtonPressed), for: .touchUpInside)
        return clButton
    }()//clearButton
    
    //Clear button pressed
    @objc func clearButtonPressed(sender: UIButton!){
        
        calculatedTimeLabel.text = "Calculated time"
        startDateButton.titleLabel?.text = "Set begin date"
        endDateButton.titleLabel?.text = "Set end date"
        startDate = ""
        startYear = ""
        endDate = ""
        endYear = ""
        
    }//clearButtonPressed
    
    func setClearButtonConstraints(){
        clearButton.topAnchor.constraint(equalTo: calculateButton.bottomAnchor, constant: 15).isActive = true
        clearButton.heightAnchor.constraint(equalToConstant: 56).isActive = true
        clearButton.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 40).isActive = true
        clearButton.centerXAnchor.constraint(equalTo: bottomView.centerXAnchor, constant: 0).isActive = true
    }//setCalculateButtonConstraints
    
    func showAlertDateEntry(alertType:AlertDataEntryType){
        
        let customAlert = self.storyboard?.instantiateViewController(withIdentifier: "CustomAlertID") as! CustomAlertViewController
        
        
        switch alertDataType {
        case .StartDate:
            customAlert.Title = "Set a start date"
            customAlert.Message = "Example: Dec 13, 8:00 AM 1989"
        case .EndDate:
            customAlert.Title = "Set an end date"
            customAlert.Message = "Example: Today or the not to distant future"
        }
        
        customAlert.alertDataType = alertDataType
        
        customAlert.providesPresentationContextTransitionStyle = true
        customAlert.definesPresentationContext = true
        customAlert.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        customAlert.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        customAlert.customAlertDelegate = self
        self.present(customAlert, animated: true, completion: nil)
        
    }//showAlertDateEntry
    
    func calcTimeDiff(startDate:String, endDate:String, startYear:String, endYear:String){
       
        if startYear.isEmpty || endYear.isEmpty{
            showErrorAlert(title: "Error", message: "Looks like you forgot to set a year. Make sure a year was set for both the start date and end date.")
        }else{
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMM d, h:mm a"
            dateFormatter.timeZone = TimeZone(abbreviation: "GMT+0:00")
            
            let yearFormatter = DateFormatter()
            yearFormatter.dateFormat = "yyyy"
            yearFormatter.timeZone = TimeZone(abbreviation: "GMT+0:00")
            
            guard let sDate = dateFormatter.date(from: startDate) else {
                fatalError()
            }
            
            guard let sYear = yearFormatter.date(from: startYear ) else {
                fatalError()
            }
            
            guard let eDate = dateFormatter.date(from: endDate) else {
                fatalError()
            }
            
            guard let eYear = yearFormatter.date(from: endYear ) else {
                fatalError()
            }
            
            let dateDiff = Calendar.current.dateComponents([.month, .weekOfYear, .day, .hour, .minute], from: sDate, to: eDate)
            
            let yearDiff = Calendar.current.dateComponents([.year], from: sYear, to: eYear)
            
            let absYear = abs(yearDiff.year ?? 0)
            let absMonth = abs(dateDiff.month ?? 0)
            let absWeek = abs(dateDiff.weekOfYear ?? 0)
            let absDay = abs(dateDiff.day ?? 0)
            let absHour = abs(dateDiff.hour ?? 0)
            let absMin = abs(dateDiff.minute ?? 0)
            
            let calculatedTime:String = "The calculated time is \(absYear) years, \(absMonth) months, \(absWeek) weeks, \(absDay) days, \(absHour) hours, and \(absMin) minutes"
            
            calculatedTimeLabel.text = calculatedTime
            
        }
        
    }//calcTimeDiff
    
    func showErrorAlert(title:String, message:String){
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Got it", style: .default, handler: nil))
        self.present(alert, animated: true)
        
    }//showErrorAlert
    
    
}//End of Viewcontroller

extension ViewController: CustomAlertViewControllerDelegate {
    
    func cancelAlertButtonPressed() {
        print("Closed")
    }
    
    func okAlertButtonPressed(date: String, year: String, alertType:AlertDataEntryType) {
        
        switch alertDataType {
        case .StartDate:
            startDate = date
            startYear = year
            
            startDateButton.titleLabel?.text = "\(startDate) \(startYear)"
            
        case .EndDate:
            endDate = date
            endYear = year
            
            endDateButton.titleLabel?.text = "\(endDate) \(endYear)"
        }
    }
}

extension UIButton {
    func setBackgroundColor(_ color: UIColor, for state: UIControl.State){
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        color.setFill()
        UIRectFill(rect)
        let colorImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        setBackgroundImage(colorImage, for: state)
    }
}

