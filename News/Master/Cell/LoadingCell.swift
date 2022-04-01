import UIKit
final class LoadingCell: UITableViewCell {
    static let cell = "loadingCell"
    let activityInd = UIActivityIndicatorView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: LoadingCell.cell)
        isUserInteractionEnabled = false
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
