
import UIKit

class DetailViewController: UIViewController {
    var detailView = DetailView()
    var detailTitle = ""
    var author = ""
    var date = ""
    var category = ""
    var detailDescription = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        constaints()
        configureView()
    }
    
    private func configureView() {
        self.title = "Detail news"
        self.view.backgroundColor = .white
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        detailView.titleLabel.text = detailTitle
        detailView.authorLabel.text = author
        detailView.dateLabel.text = date
        detailView.categoryLabel.text = "Category:\n\(category)"
        detailView.descriptionView.text = detailDescription
    }

    private func constaints() {
        view.addSubview(detailView)
        detailView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            detailView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            detailView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            detailView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 10),
            detailView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -10)
        ])
    }
}
