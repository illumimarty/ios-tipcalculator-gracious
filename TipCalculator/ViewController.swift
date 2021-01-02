//
//  ViewController.swift
//  TipCalculator
//
//  Created by Marty Nodado on 11/25/20.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var billAmountTextField: UITextField!
    @IBOutlet weak var tipPercentageLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    var tipPercentage: Double = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = "Tip Calculator"
        
        let defaults = UserDefaults.standard
        defaults.set(0.15, forKey: "tipPercentage")
        defaults.synchronize()
    }
    @IBAction func onTap(_ sender: Any) {
        print("Hello world")
        
        view.endEditing(true);
    }
    
    @IBAction func calculateTip(_ sender: Any) {
        
        //let defaults = UserDefaults.standard
        // Get the bill amount
        let bill = Double(billAmountTextField.text!) ?? 0
        // let tipPercentages = [0.15, 0.18, 0.2]
        
        
        
        // Calculate the tip and total
        
        let tip = bill * tipPercentage
        let total = bill + tip
        // Update the tip and total labels
        tipPercentageLabel.text = String(format: "$%.2f", tip)
        totalLabel.text = String(format: "$%.2f", total)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("view will appear")
    
        //let tipPercentage = defaults.double(forKey: "myDouble")
        // This is a good place to retrieve the default tip percentage from UserDefaults
        // and use it to update the tip amount
        let defaults = UserDefaults.standard
        tipPercentage = defaults.double(forKey: "tipPercentage")
        defaults.synchronize()

        calculateTip((Any).self)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("view did appear")
        billAmountTextField.becomeFirstResponder()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("view will disappear")
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("view did disappear")
    }
}


