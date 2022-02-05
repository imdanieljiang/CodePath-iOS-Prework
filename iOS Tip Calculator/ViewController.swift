//
//  ViewController.swift
//  iOS Tip Calculator
//
//  Created by Daniel Jiang on 2/3/22.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var billAmount: UITextField!
    @IBOutlet weak var tipPercentageSlider: UISlider!
    @IBOutlet weak var tipPercentage: UITextField!
    @IBOutlet weak var tipAmount: UILabel!
    @IBOutlet weak var total: UILabel!
    
    var amt: Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        billAmount.delegate = self
        billAmount.placeholder = updateAmount()
        
        let tapRecognizer = UITapGestureRecognizer()
        tapRecognizer.addTarget(self, action: #selector(ViewController.didTapView))
        self.view.addGestureRecognizer(tapRecognizer)
    }
    
    @objc func didTapView(){
      self.view.endEditing(true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        _ = billAmount.becomeFirstResponder()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let digit = Int(string) {
            amt = amt * 10 + digit
            billAmount.text = updateAmount()
        }
        if (string == "") {
            amt = amt / 10
            billAmount.text = updateAmount()
        }
        return false
    }
    
    func updateAmount() -> String? {
        let formatter = NumberFormatter()
        formatter.numberStyle = NumberFormatter.Style.currency
        let amount = Double(amt / 100) + Double(amt % 100) / 100
        return formatter.string(from: NSNumber(value: amount))
    }
    
    @IBAction func calculateTipPercentage(_ sender: Any) {
        
        // Get the tip percentage
        let tip_percentage = round(tipPercentageSlider.value) / 100
        
        // Update tip percentage
        tipPercentage.text = String(format: "%.f%%", tip_percentage * 100)
    }
    
    @IBAction func calculateBill(_ sender: Any) {
        // Get the bill amount
        let bill_string = billAmount.text ?? "$0.00"
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        if let number = formatter.number(from: bill_string) {
            let amount = number.decimalValue
            let bill_amount = NSDecimalNumber(decimal: amount).doubleValue
            
            // Get the tip percentage
            let tip_percentage = round(tipPercentageSlider.value) / 100
            
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
}
