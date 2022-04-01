import UIKit
final class MasterCell: UITableViewCell {
    static var imageCahce = NSCache<AnyObject, AnyObject>()
    static var count = 0
    let myImageView: CustomImageView = {
        var imageView = CustomImageView()
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    let customView = UIView()
    let dateLabel: UILabel = {
        var label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .gray
        label.addRightBorder(with: .systemGray3, andWidth: 2)
        return label
    }()
    let authorLabel: UILabel = {
        var label = UILabel()
        label.textAlignment = .left
        label.textColor = .red
        label.numberOfLines = 0
        return label
    }()
    let titleLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    static let cell = "masterCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: MasterCell.cell)
        selectionStyle = .none
        constraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
//MARK: - Cell constraints
    private func constraints() {
        addSubviews(views: myImageView, customView, dateLabel, authorLabel, titleLabel)
        NSLayoutConstraint.activate([
            myImageView.topAnchor.constraint(equalTo: topAnchor),
            myImageView.bottomAnchor.constraint(equalTo: centerYAnchor, constant: 30),
            myImageView.rightAnchor.constraint(equalTo: rightAnchor, constant: 30),
            myImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: -30),
            
            customView.topAnchor.constraint(equalTo: myImageView.bottomAnchor, constant: 10),
            customView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            customView.rightAnchor.constraint(equalTo: rightAnchor, constant: -10),
            customView.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
            
            titleLabel.topAnchor.constraint(equalTo: customView.topAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: dateLabel.topAnchor),
            titleLabel.rightAnchor.constraint(equalTo: rightAnchor),
            titleLabel.leftAnchor.constraint(equalTo: leftAnchor),
            
            dateLabel.topAnchor.constraint(equalTo: customView.bottomAnchor, constant: -50),
            dateLabel.bottomAnchor.constraint(equalTo:  customView.bottomAnchor),
            dateLabel.rightAnchor.constraint(equalTo: leftAnchor, constant: 110),
            dateLabel.leftAnchor.constraint(equalTo: leftAnchor),
            
            authorLabel.topAnchor.constraint(equalTo: customView.bottomAnchor, constant: -50),
            authorLabel.bottomAnchor.constraint(equalTo: customView.bottomAnchor),
            authorLabel.rightAnchor.constraint(equalTo: rightAnchor),
            authorLabel.leftAnchor.constraint(equalTo: dateLabel.rightAnchor, constant: 10)
        ])
    }
//MARK: -  Cell configure
    func configure(data: [News], indexPath: IndexPath, cell: MasterCell) {
        let array = data
        let data = array[indexPath.row]
        if data.author == "" {
            cell.authorLabel.text = "Unnamed author"
        } else {
            cell.authorLabel.text = data.author
        }
        let format = String.convertDateFormatter(date: data.published)
        cell.dateLabel.text = "\(format.0)\n\(format.1)"
        cell.titleLabel.text = data.title
        
        if let url = URL(string: data.image) {
            if data.image == "None" {
                cell.myImageView.image = UIImage(named: "default")
            } else {
                cell.myImageView.loadImage(url: url)
            }
        }
    }
}
