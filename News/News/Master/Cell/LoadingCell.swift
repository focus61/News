import UIKit
class LoadingCell: UITableViewCell {
    static var cell = "loadingCell"
    var activityInd = UIActivityIndicatorView()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: LoadingCell.cell)
        
        activityInd.translatesAutoresizingMaskIntoConstraints = false
        addSubview(activityInd)
        activityInd.isHidden = true
        NSLayoutConstraint.activate([
            activityInd.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityInd.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
