import UIKit
class MasterViewController: UIViewController {
    let activityView = UIActivityIndicatorView()
    let tableView =  CustomTableView()
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
        activityIndicatorConfig()
        view.addSubviews(views: tableView, activityView)
        tableView.delegate = self
        tableView.dataSource = self
        
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
//MARK: - TableViewDataSource configure -
extension MasterViewController: UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating {
    func numberOfSections(in tableView: UITableView) -> Int {
        var numOfSections = 0
        if searchCont.isActive && !(searchCont.searchBar.text?.isEmpty ?? false) {
            numOfSections = self.tableView.noResult(isHaveData: !filteredArray.isEmpty, tableView: tableView)
        } else {
            numOfSections = self.tableView.noResult(isHaveData: !nonFilteredArray.isEmpty, tableView: tableView)
        }
        return numOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            if isFiltered {
                return filteredArray.count
            } else {
                return nonFilteredArray.count
            }
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MasterCell.cell, for: indexPath) as? MasterCell else {
                return UITableViewCell()
            }
            if !isFiltered {
                cell.configure(data: nonFilteredArray, indexPath: indexPath, cell: cell)
            } else {
                cell.configure(data: filteredArray, indexPath: indexPath, cell: cell)
            }
            return cell
        } else {
            if nonFilteredArray.count != dataArray.count {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: LoadingCell.cell, for: indexPath) as? LoadingCell else {
                    return UITableViewCell()
                }
                if !isFiltered {
                    cell.activityInd.isHidden = false
                    cell.activityInd.startAnimating()
                } else {
                    cell.activityInd.isHidden = true
                }
                tableView.separatorStyle = .none
                return cell
            } else {
                return UITableViewCell()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 350
        } else {
            if nonFilteredArray.count != dataArray.count {
                return 30
            } else {
                return 0
            }
        }
    }
//MARK: - didSelectRow configure -
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if !isFiltered {
            pushSelectedViewController(array: nonFilteredArray, indexPath: indexPath)
        } else {
            pushSelectedViewController(array: filteredArray, indexPath: indexPath)
        }
    }
    
    private func pushSelectedViewController(array: [News], indexPath: IndexPath) {
        let data = array[indexPath.row]
        let vc = DetailViewController()
        vc.detailTitle = data.title
        vc.author = data.author
        let formatted = String.convertDateFormatter(date: data.published)
        vc.date = "\(formatted.0)\n\(formatted.1)"
        var value = ""
        for i in data.category {
            if data.category.count == 1 {
                value = i
            } else {
                value += i + " & "
            }
        }
        if data.category.count > 1 {
            for _ in 1...2 {
                value.removeLast()
            }
        }
        vc.category = value
        vc.detailDescription = data.description
        if let url = URL(string: data.image) {
            if data.image == "None" {
                vc.detailView.detailImageView.image = UIImage(named: "default")
            } else {
                vc.detailView.detailImageView.loadImage(url: url)
            }
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
}


