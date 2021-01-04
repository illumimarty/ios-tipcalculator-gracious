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
