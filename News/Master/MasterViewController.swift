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
//MARK: - TableViewDataSource configure -
extension MasterViewController: UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating {
        func numberOfSections(in tableView: UITableView) -> Int {
            var numOfSections = 0
            if searchCont.isActive && !(searchCont.searchBar.text?.isEmpty ?? false) {
                numOfSections = ifNoResultLabel(isHaveData: !filteredArray.isEmpty, tableView: tableView)
            } else {
                numOfSections = ifNoResultLabel(isHaveData: !nonFilteredArray.isEmpty, tableView: tableView)
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
//MARK: - noResult -
    func ifNoResultLabel(isHaveData: Bool, tableView: UITableView) -> Int {
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
