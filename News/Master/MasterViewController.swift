import UIKit
class MasterViewController: UIViewController {
    let activityView = UIActivityIndicatorView()
    let tableView =  UITableView()
    let searchCont = UISearchController()
    var timerCount = 0
    var dataArray = [News]()
    var nonFilteredArray = [News]()
    var filteredArray = [News]()
    var isLoadingData = false
    
    var searchIsEmpty: Bool {
        guard let txt = searchCont.searchBar.text else {return false}
        return txt.isEmpty
    }
    var isFiltered: Bool {
        return searchCont.isActive && !searchIsEmpty
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicatorConfig()
        timerForConnection()
        viewConfig()
        searchConfig()
        getData()
    }
    //MARK: - Views config -
    private func activityIndicatorConfig() {
        activityView.startAnimating()
        activityView.hidesWhenStopped = true
        activityView.isHidden = false
    }
    
    private func viewConfig() {
        self.title = "Latest news"
        view.addSubviews(views: tableView, activityView)
        tableView.isHidden = true
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(MasterCell.self, forCellReuseIdentifier: MasterCell.cell)
        tableView.register(LoadingCell.self, forCellReuseIdentifier: LoadingCell.cell)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -10),
            tableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 10),
            
            activityView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    //MARK: - if connection is failed -
    private func timerForConnection() {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] timer in
            guard let self = self else {return}
            if !self.dataArray.isEmpty {
                timer.invalidate()
            }
            self.timerCount += 1
            if self.timerCount == 15 {
                if self.dataArray.isEmpty {
                    Alert.show(self)
                }
                timer.invalidate()
            }
        }.fire()
    }
}
//MARK: - Get data and infinite scroll -
extension MasterViewController {
    private func getData() {
        Network.shared { [weak self] data in
            guard let self = self else {return}
            self.dataArray = data.news
            for i in 0..<5 {
                self.nonFilteredArray.append(self.dataArray[i])
            }
            DispatchQueue.main.async {
                self.activityView.stopAnimating()
                self.tableView.isHidden = false
                self.tableView.reloadData()
            }
            self.isLoadingData = false
        }
    }
    
    private func getMoreData() {
        if nonFilteredArray.count == dataArray.count {return}
        if !self.isLoadingData {
            self.isLoadingData = true
            let start = nonFilteredArray.count
            let end = start + 5
            DispatchQueue.global().async {
                sleep(2)
                for i in start..<end {
                    self.nonFilteredArray.append(self.dataArray[i])
                }
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    self.isLoadingData = false
                }
            }
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        if (offsetY > contentHeight - scrollView.frame.height * 4) && !isLoadingData  && nonFilteredArray.count != dataArray.count {
            getMoreData()
        }
    }
}
//MARK: - Search configure -
extension MasterViewController {
    private func searchConfig() {
        navigationItem.searchController = searchCont
        definesPresentationContext = true
        searchCont.obscuresBackgroundDuringPresentation = false
        searchCont.searchBar.placeholder = "Search Author"
        searchCont.searchResultsUpdater = self
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        filteredArray = nonFilteredArray.filter {
            $0.author.lowercased().contains(searchController.searchBar.text?.lowercased() ?? "")
        }
        tableView.reloadData()
    }
}
