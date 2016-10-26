//
//  ViewController.swift
//  Calculator
//
//  Created by Xiang, Zhuyuan | Matt | ISDOD on 24/10/16.
//  Copyright © 2016 Xiang, Zhuyuan | Matt | ISDOD. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // MARK: properties
    private var displayValue: Double{
        
        get {
            return Double(display.text!)!
        }
        set {
            display.text = String(newValue)
        }
        
    }
    private var brain = CalculatorBrain()
    private var userIntheMiddleOfTyping: Bool = false
    @IBOutlet private weak var display: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction private func touchDigit(_ sender: UIButton) {
        let digit = sender.currentTitle!
        if userIntheMiddleOfTyping {
            let textInDisplay = display.text!
            display.text = textInDisplay + digit
        
        }
        else{
            display!.text = digit
        }
        userIntheMiddleOfTyping = true
        print("touch \(digit) digit")
    }

    @IBAction private func performOperation(_ sender: UIButton) {
        if userIntheMiddleOfTyping {
            brain.setOperand(operand: displayValue)
            userIntheMiddleOfTyping = false
        }
    
        if let mathmeticasSymbol = sender.currentTitle {
           brain.performOperation(symbol: mathmeticasSymbol)
        }
        displayValue = brain.result
    }
}

