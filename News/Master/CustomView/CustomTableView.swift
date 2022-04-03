import UIKit
class CustomTableView: UITableView {
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        isHidden = true
        translatesAutoresizingMaskIntoConstraints = false
        register(MasterCell.self, forCellReuseIdentifier: MasterCell.cell)
        register(LoadingCell.self, forCellReuseIdentifier: LoadingCell.cell)
        separatorStyle = .none
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
//MARK: - noResult -
    func noResult(isHaveData: Bool, tableView: UITableView) -> Int {
        var numberOfSections = 0
        if isHaveData {
            tableView.separatorStyle = .singleLine
            numberOfSections = 2
            tableView.backgroundView = nil
        } else {
            let noDataLabel: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: tableView.bounds.size.height))
            noDataLabel.text = "No results"
            noDataLabel.font = UIFont.systemFont(ofSize: 25)
            noDataLabel.textColor = UIColor.black
            noDataLabel.textAlignment = .center
            tableView.backgroundView = noDataLabel
            tableView.separatorStyle = .none
        }
        return numberOfSections
    }
}
