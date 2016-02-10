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
    
    var isAC = true
    var justSolved = false
    var operationJustPressed = false
    var stack = [String]()
    
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
        
        if displayLabel.text == "0" || justSolved || operationJustPressed {
            displayLabel.text = num
            justSolved = false
            operationJustPressed = false
        } else {
            displayLabel.text = displayLabel.text! + num
        }
    }
    
    @IBAction func operationPressed(sender: UIButton) {
        let operation: String = sender.titleLabel!.text!
        operationJustPressed = true
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
    
    @IBAction func equalsPressed(sender: UIButton) {
        stack.append(displayLabel.text!)
        displayLabel.text = performOperation()
        clearStack()
        justSolved = true
    }
    
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

