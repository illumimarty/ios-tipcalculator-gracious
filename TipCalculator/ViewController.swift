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
    @IBOutlet weak var tipOutput: UIView!
    @IBOutlet weak var tipPercentageRef: UILabel!
    var tipPercentage: Double = 0.0
    var isDarkMode: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = "Gracious"
        
        let defaults = UserDefaults.standard
        defaults.set(0.15, forKey: "tipPercentage")
        defaults.synchronize()
        
        self.tipOutput.alpha = 0
        
        
        switch traitCollection.userInterfaceStyle {
        case .dark:
            view.backgroundColor = .tertiarySystemBackground
            
            break;
        case .light, .unspecified:
            // 88 176 121
            view.backgroundColor = UIColor(red: 216/255, green: 252/255, blue: 226/255, alpha: 1)
            break;
        default:
            print("Error: unspecified UIStyle")
        }
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
            // Trait collection has already changed
        if (traitCollection.userInterfaceStyle == .dark) {
            view.backgroundColor = .tertiarySystemBackground
        } else {
            view.backgroundColor = UIColor(red: 216/255, green: 252/255, blue: 226/255, alpha: 1)
        }
    }
    @IBAction func onTap(_ sender: Any) {
        print("Hello world")
        view.endEditing(true);
    }
    
    @IBAction func calculateTip(_ sender: Any) {
        
        // Get the bill amount
        let bill = Double(billAmountTextField.text!) ?? 0
        
        if billAmountTextField.text?.isEmpty ?? true {
            print("text field is empty")
            UIView.animate(withDuration: 0.35, animations: {
                self.tipOutput.frame = CGRect(x: 0, y: 467, width: 375, height:  200)
                self.tipOutput.alpha = 0
                self.billAmountTextField.frame = CGRect(x: 179, y: 229, width: 159.0, height: 67)
            })
        } else {
            print("text field now has text")

            tipPercentageRef.text = #"+ \#(Int(tipPercentage * 100))%"#
            UIView.animate(withDuration: 0.35, animations: {
                self.tipOutput.frame = CGRect(x: 0, y: 304, width: 375, height:  363)
                self.tipOutput.alpha = 1
                
                self.billAmountTextField.frame = CGRect(x: 183, y: 106, width: 159.0, height: 67.0)
            })
        }
        
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


