//
//  ViewController.swift
//  Calculator
//
//  Created by Zach Jiroun on 2/3/16.
//  Copyright © 2016 Zach Jiroun. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var clearButton: UIButton!
    @IBOutlet weak var displayLabel: UILabel!
    
    var firstNumber: String = ""
    var secondNumber: String = ""
    var selectedOperator = ""
    var isAC = true
    var justSolved = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        clearButton.titleLabel!.textAlignment = NSTextAlignment.Center
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func numberPressed(sender: UIButton) {
        let num: String = sender.titleLabel!.text!
        
        if isAC {
            isAC = false
            clearButton.titleLabel!.text! = "C"
        }
        
        if displayLabel.text == "0" || justSolved {
            displayLabel.text = num
            justSolved = false
        } else {
            displayLabel.text = displayLabel.text! + num
        }
        
        if selectedOperator.characters.count == 0 {
            firstNumber = displayLabel.text!
        } else {
            secondNumber = displayLabel.text!
        }
    }
    
    @IBAction func operationPressed(sender: UIButton) {
        let operation: String = sender.titleLabel!.text!
        selectedOperator = operation
        
        if justSolved {
            firstNumber = displayLabel.text!
        }
        
        displayLabel.text = "0"
    }
    
    @IBAction func plusMinusPressed(sender: UIButton) {
        
        if selectedOperator.characters.count == 0 {
            firstNumber = String(Double(firstNumber)! * -1)
            displayLabel.text = firstNumber
        } else {
            secondNumber = String(Double(secondNumber)! * -1)
            displayLabel.text = secondNumber
        }
    }
    
    @IBAction func percentPressed(sender: UIButton) {
        var num = 0.0
        if selectedOperator.characters.count == 0 {
            num = Double(firstNumber)! / 100
            firstNumber = String(num)
            displayLabel.text = firstNumber
        } else {
            num = Double(secondNumber)! / 100
            secondNumber = String(num)
            displayLabel.text = firstNumber
        }
    }
    
    @IBAction func equalsPressed(sender: UIButton) {
        displayLabel.text = performOperation(selectedOperator)
        resetValues()
        justSolved = true
    }
    
    func performOperation(operation: String) -> String {
        var result: Double = 0
        switch selectedOperator {
        case "+":
            result = Double(firstNumber)! + Double(secondNumber)!
        case "-":
            result = Double(firstNumber)! - Double(secondNumber)!
        case "x":
            result = Double(firstNumber)! * Double(secondNumber)!
        case "/":
            result = Double(firstNumber)! / Double(secondNumber)!
        default:
            break
        }
        return String(result)
    }
    
    @IBAction func clearPressed(sender: UIButton) {
        isAC = true
        displayLabel.text = "0"
        justSolved = false
        resetValues()
    }
    
    func resetValues() {
        firstNumber = ""
        secondNumber = ""
        selectedOperator = ""
    }
    
}

