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
    var typpingBool = false

//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//
//    }
    
    @IBAction func digitBtn(_ sender: UIButton) {
        let digitLabel = sender.tag - 1
        if outputLabel != nil {
            if !typpingBool {
                outputLabel.text = "\(digitLabel)"
                typpingBool = true
            } else {
                outputLabel.text = outputLabel.text! + "\(digitLabel)"
            }
        }
    }
    
    var displayValue: Double {
        get {
            return Double(outputLabel.text!)!
        }
        set {
            if floor(newValue) == newValue {
                outputLabel.text = "\(Int(newValue))"
            }else {
                outputLabel.text = String(newValue)
            }
            
        }
    }
    
    private var operation = CalculatorOperand()
    
    @IBAction func functionOperation(_ sender: UIButton) {
        let mathematicalInt = sender.tag
        if typpingBool {
            operation.passValue(displayValue)
            typpingBool = false
        }
        if mathematicalInt > 0 {
            print("Go to Binary Operation ...")
            operation.performedOperation(mathematicalInt)
        }
        if let result = operation.result {
            displayValue = result
        }
        
    }
    
    @IBOutlet weak var showNumLabel: UILabel!
    @IBOutlet weak var outputLabel: UILabel!
    
    private func initLabel() {
        showNumLabel.text = ""
        outputLabel.text = "0"
    }

}
