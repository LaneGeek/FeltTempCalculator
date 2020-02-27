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
        windSpeed = metricUnits ? Int(Double(windSpeed) / 1.6) : windSpeed
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
    }
    
    func updateDisplay() {
        windSpeedLabel.text = "Wind Speed: " + String(metricUnits ? Int(Double(windSpeed) * 1.6) : windSpeed) + (metricUnits ? " kph" : " mph")
        windSpeedSliderValue.value = Float(windSpeed)
        humidityLabel.text = "Humidity: " + String(humidity) + " %"
        humiditySliderValue.value = Float(humidity)
        unitsSwitchState.isOn = metricUnits
        // todo color selector
    }
}
