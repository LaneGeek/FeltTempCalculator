import UIKit

class HistoryTableViewController: UITableViewController {
    
    // The field which stores the history
    var history: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // The number of rows
        return history.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Temporary cell to filled with data
        let cell = UITableViewCell()
        // Fill it with a reading from history
        cell.textLabel?.text = history[indexPath.row]
        return cell
    }
}
