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
    @IBOutlet weak var partyOf2: UILabel!
    @IBOutlet weak var partyOf3: UILabel!
    @IBOutlet weak var partyOf4: UILabel!
    
    var tipPercentage: Double = 0.0
    var isDarkMode: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = "Gracious"
        self.tipOutput.alpha = 0
        
        // Sets default tip percentage
        let defaults = UserDefaults.standard
        defaults.set(0.15, forKey: "tipPercentage")
        defaults.synchronize()
        
        // Dark Mode Feature
        switch traitCollection.userInterfaceStyle {
            case .dark:
                view.backgroundColor = .tertiarySystemBackground
                break;
            case .light, .unspecified:
                view.backgroundColor = UIColor(red: 216/255, green: 252/255, blue: 226/255, alpha: 1)
                break;
            default:
                print("Error: unspecified UIStyle")
        }
    }
    
    // Dark Mode appearance change after app loads
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        // Trait collection has already changed
        if (traitCollection.userInterfaceStyle == .dark) {
            view.backgroundColor = .tertiarySystemBackground
        } else {
            view.backgroundColor = UIColor(red: 216/255, green: 252/255, blue: 226/255, alpha: 1)
        }
    }
    
    @IBAction func onTap(_ sender: Any) {
        print("Tap Event")
        view.endEditing(true);
    }
    
    @IBAction func calculateTip(_ sender: Any) {
        
        // Get the bill amount
        let bill = Double(billAmountTextField.text!) ?? 0
        
        // Totals View animation when text field is/is not empty
        if billAmountTextField.text?.isEmpty ?? true || bill == 0 {
            print("Text Field empty or == 0")
            UIView.animate(withDuration: 0.35, animations: {
                self.tipOutput.frame = CGRect(x: 0, y: 467, width: 375, height:  200)
                self.tipOutput.alpha = 0
            })
        } else {
            print("Text Field not empty")
            tipPercentageRef.text = #"+ \#(Int(tipPercentage * 100))%"#
            UIView.animate(withDuration: 0.35, animations: {
                self.tipOutput.frame = CGRect(x: 0, y: 304, width: 375, height:  363)
                self.tipOutput.alpha = 1
            })
        }
        
        // Calculate the tip and total
        let tip = bill * tipPercentage
        let total = bill + tip
        
        // Update the tip and total labels
        tipPercentageLabel.text = String(format: "$%.2f", tip)
        totalLabel.text = String(format: "$%.2f", total)
        
        partyOf2.text = String(format: "$%.2f", total / 2)
        partyOf2.font = partyOf2.font.withSize(40)
        
        partyOf3.text = String(format: "$%.2f", total / 3)
        partyOf3.font = partyOf2.font.withSize(35)

        
        partyOf4.text = String(format: "$%.2f", total / 4)
        partyOf4.font = partyOf2.font.withSize(30)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("view will appear")
    
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
        
        // Keyboard always on when view is loaded
        billAmountTextField.becomeFirstResponder()
    }
}


