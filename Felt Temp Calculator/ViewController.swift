import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var temperatureTextField: UITextField!
    @IBOutlet weak var humidityTextField: UITextField!
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var feltTemperatureLabel: UILabel!
    
    var windSpeed = 50
    var temperature = 50
    var humidity = 50
    var humidityMode = true
    var history = ["Yo1", "Yo2"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateDisplay()
    }
    
    // This is for getting rid of the keyboard by touching anywhere else
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }

    @IBAction func windSpeedSlider(_ sender: UISlider) {
        windSpeed = Int(sender.value)
        windSpeedLabel.text = String(windSpeed) + " mph"
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
    
    @IBAction func historyButtonClicked(_ sender: UIButton) {
        performSegue(withIdentifier: "historySegue", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let historyVC = segue.destination as? HistoryTableViewController {
            historyVC.history = history
        }
    }
    
    func updateDisplay() {
        // If either is blank it is assumed to be zero
        temperature = Int(temperatureTextField.text ?? "0") ?? 0
        humidity = Int(humidityTextField.text ?? "0") ?? 0
        
        var feltTemperature: Int

        // As agreed in class the threshold is 70 degrees
        if temperature < 70 {
            feltTemperature = Int(CalculationsLibrary.windChill(temperature: Double(temperature), velocity: Double(windSpeed)))
        } else if humidityMode {
            feltTemperature = Int(CalculationsLibrary.heatIndex(temperature: Double(temperature), humidity: Double(humidity)))
        } else {
            feltTemperature = temperature
        }
        
        feltTemperatureLabel.text = String(feltTemperature) + " ℉ " + CalculationsLibrary.temperatureToEmoji(temperature: feltTemperature)
    }
}
