import UIKit

class DataViewController: UIViewController {
    
    var color = UIColor()
    var index = Int()
    var months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
    var days = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
    let cellIdentifier = "cell"
    
    lazy var tableView: UITableView = {
        let style = UITableView.Style.insetGrouped
        let tblView = UITableView(frame: .zero, style: style)
        return tblView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = color
        configureTableView()
    }
    
    private func configureTableView() {
        self.view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.frame = self.view.frame
        tableView.register(TCell.self, forCellReuseIdentifier: cellIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension DataViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return months.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return days.count
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return months[section]
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? TCell else { return UITableViewCell() }
        
        cell.setCell(label: months[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

class TCell: UITableViewCell {
    
    var label: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont(descriptor: .preferredFontDescriptor(withTextStyle: .largeTitle), size: 20)
        label.frame = CGRect(x: 8, y: 5, width: 100, height: 50)
        return label
    }()
    
    func setCell(label: String) { self.label.text = label }
}
