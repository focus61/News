
import UIKit

class DetailViewController: UIViewController {
    var detailView = DetailView()
    var detailTitle = ""
    var author = ""
    var date = ""
    var category = ""
    var detailDescription = ""
    override func viewWillLayoutSubviews() {
        constaints()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Detail news"
        self.view.backgroundColor = .white
        self.navigationController?.navigationBar.prefersLargeTitles = true
        configureView()
    }
    private func constaints() {
        view.addSubview(detailView)
        detailView.translatesAutoresizingMaskIntoConstraints = false
        detailView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        detailView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10).isActive = true
        detailView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 10).isActive = true
        detailView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -10).isActive = true
    }
    private func configureView() {
        detailView.titleLabel.text = detailTitle
        detailView.authorLabel.text = author
        detailView.dateLabel.text = date
        detailView.categoryLabel.text = "Category:\n\(category)"
        detailView.descriptionLabel.text = detailDescription
    }
}

