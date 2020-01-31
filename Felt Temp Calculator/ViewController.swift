//
//  ViewController.swift
//  Felt Temp Calculator
//
//  Created by Wolfgang on 1/31/20.
//  Copyright © 2020 Wolfgang's Software Factory. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var temperatureTextField: UITextField!
    @IBOutlet weak var humidityTextField: UITextField!
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var feltTemperatureLabel: UILabel!
    
    var windSpeed = 50
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func windSpeedSlider(_ sender: UISlider) {
        windSpeed = Int(sender.value)
        windSpeedLabel.text = String(windSpeed) + " mph"
    }
}
