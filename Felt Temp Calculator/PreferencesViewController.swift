import UIKit

class PreferencesViewController: UIViewController {
    
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var windSpeedSliderValue: UISlider!
    @IBOutlet weak var humiditySliderValue: UISlider!
    @IBOutlet weak var unitsSwitchState: UISwitch!
    @IBOutlet weak var colorSelector: UISegmentedControl!
    
    // Get user defaults
    var windSpeed = UserDefaults.standard.integer(forKey: "windSpeed")
    var humidity = UserDefaults.standard.integer(forKey: "humidity")
    var metricUnits = UserDefaults.standard.bool(forKey: "metricUnits")
    var color = UserDefaults.standard.string(forKey: "color")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateDisplay()
    }
    
    @IBAction func windSpeedSlider(_ sender: UISlider) {
        windSpeed = Int(sender.value)
        UserDefaults.standard.set(windSpeed, forKey: "windSpeed")
        updateDisplay()
    }
    
    @IBAction func humiditySlider(_ sender: UISlider) {
        humidity = Int(sender.value)
        UserDefaults.standard.set(humidity, forKey: "humidity")
        updateDisplay()
    }
    
    @IBAction func unitsSwitch(_ sender: UISwitch) {
        metricUnits = sender.isOn
        UserDefaults.standard.set(metricUnits, forKey: "metricUnits")
        updateDisplay()
    }
    
    @IBAction func colorSelector(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            color = "white"
        case 1:
            color = "red"
        default:
            color = "yellow"
        }
        UserDefaults.standard.set(color, forKey: "color")
        updateDisplay()
    }
    
    @IBAction func factoryResetButtonClicked(_ sender: UIButton) {
        windSpeed = 10
        UserDefaults.standard.set(windSpeed, forKey: "windSpeed")
        humidity = 40
        UserDefaults.standard.set(humidity, forKey: "humidity")
        metricUnits = false
        UserDefaults.standard.set(metricUnits, forKey: "metricUnits")
        color = "white"
        UserDefaults.standard.set(color, forKey: "color")
        updateDisplay()
    }
    
    func updateDisplay() {
        // Update UI
        windSpeedLabel.text = "Wind Speed: " + String(metricUnits ? Int(Double(windSpeed) * 1.6) : windSpeed) + (metricUnits ? " kph" : " mph")
        windSpeedSliderValue.value = Float(windSpeed)
        humidityLabel.text = "Humidity: " + String(humidity) + " %"
        humiditySliderValue.value = Float(humidity)
        unitsSwitchState.isOn = metricUnits
        
        // Set color swich to what it currently is
        switch color {
        case "white":
            colorSelector.selectedSegmentIndex = 0
        case "red":
            colorSelector.selectedSegmentIndex = 1
        default:
            colorSelector.selectedSegmentIndex = 2
        }
    }
}
