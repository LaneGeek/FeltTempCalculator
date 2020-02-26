import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var temperatureTextField: UITextField!
    @IBOutlet weak var humidityTextField: UITextField!
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var feltTemperatureLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var windSpeedSliderValue: UISlider!
    
    var windSpeed = 10
    var temperature = 70
    var humidity = 40
    var humidityMode = true
    var history: [String] = []
    var metricUnits = false
    var color = "white"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if !UserDefaults.standard.bool(forKey: "defaultsStored") {
            // Set prefernces if first time
            UserDefaults.standard.set(10, forKey: "windSpeed")
            UserDefaults.standard.set(40, forKey: "humidity")
            UserDefaults.standard.set(false, forKey: "metricUnits")
            UserDefaults.standard.set("white", forKey: "color")
            UserDefaults.standard.set([], forKey: "history")
            // Set flag that data is now stored
            UserDefaults.standard.set(true, forKey: "defaultsStored")
        } else {
            // Retrieve prefernces
            windSpeed = UserDefaults.standard.integer(forKey: "windSpeed")
            humidity = UserDefaults.standard.integer(forKey: "humidity")
            metricUnits = UserDefaults.standard.bool(forKey: "metricUnits")
            color = UserDefaults.standard.string(forKey: "color")!
            history = UserDefaults.standard.array(forKey: "history") as! [String]
        }
        
        updateDisplay()
    }
    
    // This is for getting rid of the keyboard by touching anywhere else
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    @IBAction func windSpeedSlider(_ sender: UISlider) {
        windSpeed = Int(sender.value)
        windSpeed = metricUnits ? Int(Double(windSpeed) * 1.6) : windSpeed
        updateDisplay()
    }
    
    @IBAction func temperatureOrHumidityEditingDidEnd(_ sender: Any) {
        updateDisplay()
    }
    
    @IBAction func humidityModeChanged(_ sender: UISwitch) {
        // The action sheet is created
        let action = UIAlertController(title: "Humidity Mode", message: "Do you want to change it?", preferredStyle: .actionSheet)
        
        // The yes action will create an alert
        let yesAction = UIAlertAction(title: "Yes I do.", style: .default, handler: {
            (_: UIAlertAction) -> Void in
            let alert = UIAlertController(title: "Humidity Mode", message: "Is now changed!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .default))
            self.present(alert, animated: true, completion: nil)
            self.humidityMode = sender.isOn
            self.updateDisplay()
        })
        
        // The no action will flip the switch back
        let noAction = UIAlertAction(title: "No, I changed my mind!", style: .default, handler: {
            (_: UIAlertAction) -> Void in
            sender.setOn(!sender.isOn, animated: true)
            self.humidityMode = sender.isOn
            self.updateDisplay()
        })
        
        // Add the actions to the action sheet
        action.addAction(yesAction)
        action.addAction(noAction)
        
        // Show the action sheet
        present(action, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the current time & date and format it
        let timeAndDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, h:mm:ss a"
        let formattedDate = dateFormatter.string(from: timeAndDate)
        let temperatureReading = formattedDate + " - " + (feltTemperatureLabel.text ?? "")
        
        // If the temp has changed then add the new reading to history
        if history.count != 0 {
            if history[0] != temperatureReading {
                history.insert(temperatureReading, at: 0)
            }
        } else {
            history.insert(temperatureReading, at: 0)
        }
        
        // Save history to user defaults
        UserDefaults.standard.set(history, forKey: "history")
        
        // If the segue destination is history then set the destination's data to the history here
        if let historyVC = segue.destination as? HistoryTableViewController {
            historyVC.history = history
        }
    }
    
    func updateDisplay() {
        // If either is blank it is assumed to be zero
        temperature = Int(temperatureTextField.text ?? "0") ?? 0
        humidity = Int(humidityTextField.text ?? "0") ?? 0
        
        temperatureLabel.text = "Temp " + (metricUnits ? "℃" : "℉")
        windSpeedSliderValue.value = Float(windSpeed)
        windSpeedLabel.text = String(windSpeed) + (metricUnits ? "kph" : " mph")
        humidityTextField.text = String(humidity)
        temperature = metricUnits ? CalculationsLibrary.cToF(c: temperature) : temperature
        
        var feltTemperature: Int
        
        // As agreed in class the threshold is 70 degrees
        if temperature < 70 {
            feltTemperature = Int(CalculationsLibrary.windChill(temperature: Double(temperature), velocity: Double(windSpeed)))
        } else if humidityMode {
            feltTemperature = Int(CalculationsLibrary.heatIndex(temperature: Double(temperature), humidity: Double(humidity)))
        } else {
            feltTemperature = temperature
        }
        
        let emoji = CalculationsLibrary.temperatureToEmoji(temperature: feltTemperature)
        
        if metricUnits {
            feltTemperature = CalculationsLibrary.fToC(f: feltTemperature)
            feltTemperatureLabel.text = String(feltTemperature) + " ℃ " + emoji
        } else {
            feltTemperatureLabel.text = String(feltTemperature) + " ℉ " + emoji
        }
    }
}
