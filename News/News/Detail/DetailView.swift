import UIKit

final class DetailView: UIView {
    var detailImageView: CustomImageView = {
        var imgView = CustomImageView()
        return imgView
    }()
    
    var titleLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 25)
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    var authorLabel: UILabel = {
        var label = UILabel()
        label.textAlignment = .left
        label.textColor = .red
        label.numberOfLines = 0
        return label
    }()
    var dateLabel: UILabel = {
        var label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .gray
        label.addRightBorder(with: .systemGray3, andWidth: 2)
        return label
    }()
    var categoryLabel: UILabel = {
        var label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 15)
        label.numberOfLines = 0
        return label
    }()
    var descriptionView: UITextView = {
        var textView = UITextView()
        textView.font = UIFont.systemFont(ofSize: 18)
        textView.adjustsFontForContentSizeCategory = true
        textView.isEditable = false
        textView.text = " "
        textView.textAlignment = .left
        return textView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews(views: detailImageView, titleLabel, authorLabel, dateLabel, categoryLabel, descriptionView)
        constraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func constraints() {
        NSLayoutConstraint.activate([
            
            detailImageView.topAnchor.constraint(equalTo: topAnchor),
            detailImageView.heightAnchor.constraint(equalToConstant: 200),
            detailImageView.rightAnchor.constraint(equalTo: rightAnchor),
            detailImageView.leftAnchor.constraint(equalTo: leftAnchor),
    
            titleLabel.topAnchor.constraint(equalTo: detailImageView.bottomAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 100),
            titleLabel.rightAnchor.constraint(equalTo: rightAnchor),
            titleLabel.leftAnchor.constraint(equalTo: leftAnchor),
            
            authorLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            authorLabel.heightAnchor.constraint(equalToConstant: 60),
            authorLabel.rightAnchor.constraint(equalTo: rightAnchor),
            authorLabel.leftAnchor.constraint(equalTo: leftAnchor),
            
            dateLabel.topAnchor.constraint(equalTo: authorLabel.bottomAnchor),
            dateLabel.heightAnchor.constraint(equalToConstant: 40),
            dateLabel.rightAnchor.constraint(equalTo: leftAnchor, constant: 110),
            dateLabel.leftAnchor.constraint(equalTo: leftAnchor),
            
            categoryLabel.topAnchor.constraint(equalTo: authorLabel.bottomAnchor),
            categoryLabel.heightAnchor.constraint(equalToConstant: 40),
            categoryLabel.rightAnchor.constraint(equalTo: rightAnchor),
            categoryLabel.leftAnchor.constraint(equalTo: dateLabel.rightAnchor, constant: 10),
            
            descriptionView.topAnchor.constraint(equalTo: categoryLabel.bottomAnchor),
            descriptionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            descriptionView.rightAnchor.constraint(equalTo: rightAnchor, constant: 5),
            descriptionView.leftAnchor.constraint(equalTo: leftAnchor, constant: -5)
            
        ])
    }
}
