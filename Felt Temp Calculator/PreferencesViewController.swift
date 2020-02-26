import UIKit

class PreferencesViewController: UIViewController {
    
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
        
    @IBAction func windSpeedSlider(_ sender: UISlider) {
    }
    
    @IBAction func humiditySlider(_ sender: UISlider) {
    }
    
    @IBAction func unitsSwitch(_ sender: UISwitch) {
    }
    
    @IBAction func colorSelector(_ sender: UISegmentedControl) {
    }
}
