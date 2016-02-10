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
    
    var isAC = true // Determines if the clear button functions as AC or C
    var justSolved = false // Prevents appending onto a displayed solved calculation.
    var operandJustPressed = false // Resets the displayLabel after an operand is pressed.
    
    // Represents the calculation values as Strings [Value1, Operand, Value2]. Max of 3 values. Ex. ["1", "+", "2"]
    var stack = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        clearButton.titleLabel!.textAlignment = NSTextAlignment.Center
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Determines UI State when a number/decimal is tapped
    @IBAction func numberPressed(sender: UIButton) {
        let num: String = sender.titleLabel!.text!
        
        if isAC {
            isAC = false
            clearButton.titleLabel!.text! = "C"
        }
        
        if displayLabel.text == "0" || justSolved || operandJustPressed {
            displayLabel.text = num
            justSolved = false
            operandJustPressed = false
        } else {
            displayLabel.text = displayLabel.text! + num
        }
    }
    
    // Determines UIState when an operand is tapped
    @IBAction func operationPressed(sender: UIButton) {
        let operation: String = sender.titleLabel!.text!
        operandJustPressed = true
        if stack.count == 2 {
            stack.append(displayLabel.text!)
            let newResult = performOperation()
            clearStack()
            stack.append(newResult)
            displayLabel.text! = newResult
        } else {
            stack.append(displayLabel.text!)
        }
        stack.append(operation)
    }
    
    // Multiplies the current value by -1
    @IBAction func plusMinusPressed(sender: UIButton) {
        displayLabel.text = String(Double(displayLabel.text!)! * -1)
    }
    
    // Divides the current value by 100
    @IBAction func percentPressed(sender: UIButton) {
        displayLabel.text = String(Double(displayLabel.text!)! / 100)
    }
    
    // Updates the displayLabel with the results of a calculation.
    @IBAction func equalsPressed(sender: UIButton) {
        stack.append(displayLabel.text!)
        displayLabel.text = performOperation()
        clearStack()
        justSolved = true
    }
    
    // Performs calculations based off the stack, returns "0" if stack does contain 3 elements.
    func performOperation() -> String {
        
        var result: Double = 0
        
        if stack.count == 3 {
            switch stack[1] {
            case "+":
                result = Double(stack[0])! + Double(stack[2])!
            case "-":
                result = Double(stack[0])! - Double(stack[2])!
            case "x":
                result = Double(stack[0])! * Double(stack[2])!
            case "/":
                result = Double(stack[0])! / Double(stack[2])!
            default:
                break
            }
        }
        return String(result)
    }
    
    // Pressing C will clear the first number, AC will clear everything
    @IBAction func clearPressed(sender: UIButton) {
        
        if clearButton.titleLabel!.text! == "C" {
            displayLabel.text = "0"
        } else {
            justSolved = false
            clearStack()
        }
        
        isAC = true
    }
    
    func clearStack() {
        stack = []
    }
    
}

