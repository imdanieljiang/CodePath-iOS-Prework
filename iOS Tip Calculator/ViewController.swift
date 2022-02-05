//
//  ViewController.swift
//  iOS Tip Calculator
//
//  Created by Daniel Jiang on 2/3/22.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var billAmount: UITextField!
    @IBOutlet weak var tipPercentageSlider: UISlider!
    @IBOutlet weak var tipPercentage: UITextField!
    @IBOutlet weak var tipAmount: UILabel!
    @IBOutlet weak var total: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func calculateTip(_ sender: Any) {
        // Get the bill amount
        let bill_amount = Double(billAmount.text!) ?? 0
        
        // Get the tip percentage
        let tip_percentage = round(tipPercentageSlider.value) / 100
        
        // Update tip percentage
        tipPercentage.text = String(format: "%.f%%", tip_percentage * 100)
        
        // Get tip amount by multiplying bill amount * tip percentage
        let tip_amount = bill_amount * Double(tip_percentage)
        
        // Calculate the total bill
        let total_bill = bill_amount + tip_amount
        
        // Update the tip amount
        tipAmount.text = String(format: "$%.2f", tip_amount)
        
        // Update the total bill amount
        total.text = String(format: "$%.2f", total_bill)
    }
}
