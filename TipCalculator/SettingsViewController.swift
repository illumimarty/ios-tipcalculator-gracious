//
//  SettingsViewController.swift
//  TipCalculator
//
//  Created by Marty Nodado on 12/20/20.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var tipControl: UISegmentedControl!
    let tipPercentages = [0.15, 0.18, 0.2]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.title = "Settings"
        
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("view will appear")
    
        // This is a good place to retrieve the default tip percentage from UserDefaults
        // and use it to update the tip amount
        let defaults = UserDefaults.standard

        if (defaults.double(forKey: "tipPercentage") != tipPercentages[tipControl.selectedSegmentIndex]) {
            
            tipControl.selectedSegmentIndex = defaults.integer(forKey: "tipControlIndex")

        }
        defaults.synchronize()
    
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("view will disappear")
        let defaults = UserDefaults.standard

        defaults.set(tipPercentages[tipControl.selectedSegmentIndex], forKey: "tipPercentage")
        defaults.set(tipControl.selectedSegmentIndex, forKey: "tipControlIndex")
        defaults.synchronize()
    }
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
