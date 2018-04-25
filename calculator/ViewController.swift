//
//  ViewController.swift
//  calculator
//
//  Created by White on 2018/4/21.
//  Copyright © 2018年 White. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initLabel()
        // Do any additional setup after loading the view, typically from a nib.
    }
    private var typpingBool = false
    private var operandBool = false
    private var dotFlag = false
    private var overOperation = false
    
    //    override func didReceiveMemoryWarning() {
    //        super.didReceiveMemoryWarning()
    //        // Dispose of any resources that can be recreated.
    //
    //    }
    
    @IBAction func digitBtn(_ sender: UIButton) {
        let digitLabel = sender.tag - 1
        if !overOperation {
            if outputLabel != nil {
                if !typpingBool {
                    outputLabel.text = "\(digitLabel)"
                    typpingBool = true
                } else {
                    outputLabel.text = outputLabel.text! + "\(digitLabel)"
                }
            }
        }
    }
    
    var displayValue: String {
        get {
            return outputLabel.text!
        }
        set {
            let fixDotZero = Double(newValue)!
            if floor(fixDotZero) == fixDotZero {
                outputLabel.text = "\(Int(fixDotZero))"
            }else {
                //if operandBool {
                    outputLabel.text = newValue
                //}
            }
        }
    }
    
    private var operation = CalculatorOperand()
    
    @IBAction func functionOperation(_ sender: UIButton) {
        let mathematicalInt = sender.tag
        if !overOperation {
            if typpingBool {
                if operandBool {
                    showNumLabel.text = showNumLabel.text! + outputLabel.text! + " = "
                    overOperation = true
                }
                operation.passValue(displayValue)
                typpingBool = false
            }
            if mathematicalInt > 0 {
                //showNumLabel.text = outputLabel.text! // copy the output.
                if !operandBool {addStringToShowNumber(mathematicalInt)}
                print("Go to Binary Operation ...")
                operation.performedOperation(mathematicalInt)
                dotFlag = false
            }
            if let result = operation.result {
                displayValue = result
                if !operandBool {
                    if mathematicalInt == 2 {showNumLabel.text = "±(" + outputLabel.text! + ")"}
                    else {showNumLabel.text = displayValue}
                    
                }
            }
        }
        
    }
    
    private func addStringToShowNumber(_ addMathematical: Int){
        operandBool = true
        //dotFlag = true
        print("In the addStraddStringToShowNumber Function.")
        switch addMathematical {
        case 2:
            showNumLabel.text = "±(" + outputLabel.text! + ")"
            operandBool = false
        case 3:
            operandBool = false
            showNumLabel.text = displayValue// + " ﹪ "
        case 4:
            showNumLabel.text = displayValue + " ÷ "
        case 5:
            showNumLabel.text = displayValue + " × "
        case 6:
            showNumLabel.text = displayValue + " − "
        case 7:
            showNumLabel.text = displayValue + " + "
            break
        default:
            break
        }
    }
    @IBAction func dotNumber(_ sender: UIButton) {
        if !dotFlag {
            outputLabel.text = outputLabel.text! + "."
            dotFlag = true
        }
    }
    @IBAction func goToDefault(_ sender: UIButton) {
        initLabel()
    }
    
    @IBOutlet weak var showNumLabel: UILabel!
    @IBOutlet weak var outputLabel: UILabel!
    
    private func initLabel() {
        operation.passValue("0")
        showNumLabel.text = "0"
        outputLabel.text = "0"
        typpingBool = false
        operandBool = false
        dotFlag = false
        overOperation = false
    }
    
}

