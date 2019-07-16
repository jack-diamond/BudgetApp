//
//  ViewController.swift
//  Budget App
//
//  Created by Jack Diamond on 6/23/19.
//  Copyright © 2019 Jack Diamond. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate, UIApplicationDelegate {

    @IBOutlet weak var needLabel: UILabel!
    @IBOutlet weak var wantLabel: UILabel!
    @IBOutlet weak var saveLabel: UILabel!
    @IBOutlet weak var addMoney: UITextField!
    @IBOutlet weak var subNeed: UITextField!
    @IBOutlet weak var subWant: UITextField!
    @IBOutlet weak var subSave: UITextField!

    
    
    let defaults = UserDefaults.standard
    
    var need: Double = 0.0
    var want: Double = 0.0
    var save: Double = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        addMoney.delegate = self
        subNeed.delegate = self
        subWant.delegate = self
        subSave.delegate = self
        getValues()
        setValues()
    }
    
    // Get saved values for the budget categories
    func getValues() {
        need = defaults.double(forKey: "need")
        want = defaults.double(forKey: "want")
        save = defaults.double(forKey: "save")
    }
    
    // Set the values on display
    func setValues() {
        needLabel.text = convertDouble(num: need)
        wantLabel.text = convertDouble(num: want)
        saveLabel.text = convertDouble(num: save)
    }
    
    // Add income to all categories with given ratio
    func updateValuesAdd()
    {
        guard let money = Double(addMoney.text!) else {
            return
        }
        
        let tempNeed = need
        let tempWant = want
        let tempSave = save
        
        // Calculate values
        need = calculateValue(value: money, percentage: 50.0)
        want = calculateValue(value: money, percentage: 30.0)
        save = calculateValue(value: money, percentage: 20.0)
        
        // Add pre-existing values to new calculation
        need = need + tempNeed
        want = want + tempWant
        save = save + tempSave
        
        // Update values
        needLabel.text = convertDouble(num: need)
        wantLabel.text = convertDouble(num: want)
        saveLabel.text = convertDouble(num: save)
        
        saveValues()
    }

    func updateValueSubNeed()
    {
        guard let money = Double(subNeed.text!) else {
            return
        }
        
        let tempNeed = need
        
        // Calculate values
        need = calculateValue(value: money, percentage: 50.0)
        
        // Add pre-existing values to new calculation
        need = need - tempNeed
        
        // Update values
        needLabel.text = convertDouble(num: need)

        saveValues()
    }
    
    func updateValueSubWant()
    {
        guard let money = Double(subWant.text!) else {
            return
        }
        
        let tempWant = want
        
        // Calculate values
        want = calculateValue(value: money, percentage: 30.0)
        
        // Add pre-existing values to new calculation
        want = want - tempWant
        
        // Update values
        wantLabel.text = convertDouble(num: want)
        
        saveValues()
    }
    
    func updateValueSubSave()
    {
        guard let money = Double(subSave.text!) else {
            return
        }
        
        
        // Subtract money from Save category
        save = save - money
        
        // Update values
        saveLabel.text = convertDouble(num: save)
        
        saveValues()
    }
    
    func calculateValue(value: Double, percentage: Double) -> Double
    {
        return value * (percentage / 100.0)
    }
    
    func convertDouble(num: Double) -> String
    {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        numberFormatter.locale = Locale.current
        
        return numberFormatter.string(from: NSNumber(value: num))!
    }
    
    func saveValues() {
        let defaults = UserDefaults.standard
        
        defaults.set(need, forKey: "need")
        defaults.set(want, forKey: "want")
        defaults.set(save, forKey: "save")
    }
    // UITextFieldDelegate Methods
    
    func hideKeyboardM () {
        addMoney.resignFirstResponder()
    }
    
    func hideKeyboardN () {
        subNeed.resignFirstResponder()
    }
    
    func hideKeyboardW () {
        subWant.resignFirstResponder()
    }
    
    func hideKeyboardS () {
        subSave.resignFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == addMoney {
            print("pressedAdd")
            updateValuesAdd()
            hideKeyboardM()
            addMoney.text = ""
            return true
        }
        else if textField == subNeed {
            print("pressedSubNeed")
            updateValueSubNeed()
            hideKeyboardN()
            subNeed.text = ""
            return true
        }
        else if textField == subWant {
            print("pressedSubWant")
            updateValueSubWant()
            hideKeyboardW()
            subWant.text = ""
            return true
        }
        else if textField == subSave {
            print("pressedSubSave")
            updateValueSubSave()
            hideKeyboardS()
            subSave.text = ""
            return true
        }
        return true
    }
    
  /* func applicationWillTerminate(_ application: UIApplication) {
        let defaults = UserDefaults.standard
        
        defaults.set(need, forKey: "need")
        defaults.set(want, forKey: "want")
        defaults.set(save, forKey: "save")
    
        print("haha")
    }
 */
}

