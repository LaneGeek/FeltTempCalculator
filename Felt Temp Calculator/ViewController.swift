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
        humidityMode = sender.isOn
        updateDisplay()
    }
    
    func updateDisplay() {
        temperature = Int(temperatureTextField.text ?? "0") ?? 0
        humidity = Int(humidityTextField.text ?? "0") ?? 0
        feltTemperatureLabel.text = String(Int(CalculationsLibrary.windChill(temperature: Double(temperature), velocity: Double(windSpeed)))) + " ℉"
    }
}
