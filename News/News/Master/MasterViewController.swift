
import UIKit

class MasterViewController: UIViewController {
    private var timerCount = 0
    private var tableView =  UITableView()
    private let searchCont = UISearchController()
    private let backgroundView = UILabel()
    private var mainArray = [News]()
    private var array = [News]()
    private var filteredArray = [News]()
    private var isLoadingData = false
    var activityView = UIActivityIndicatorView()
    
    private var searchIsEmpty: Bool {
        guard let txt = searchCont.searchBar.text else {return false}
        return txt.isEmpty
    }
    private var isFiltered: Bool {
        return searchCont.isActive && !searchIsEmpty
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timerForConnection()
        viewConfig()
        searchConfig()
        getData()
    }
    private func activityConfig() {
        view.addSubview(activityView)
        activityView.translatesAutoresizingMaskIntoConstraints = false
        activityView.startAnimating()
        activityView.hidesWhenStopped = true
    }
    private func viewConfig() {
        self.title = "Latest news"
        navigationController?.navigationBar.prefersLargeTitles = true
        view.addSubview(tableView)
        tableView.addSubview(backgroundView)
        activityConfig()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        backgroundView.isHidden = true
        backgroundView.font = UIFont.systemFont(ofSize: 30)
        backgroundView.textAlignment = .center
        NSLayoutConstraint.activate([
            
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -10),
            tableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 10),
            
            backgroundView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            backgroundView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            activityView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
        
        tableView.register(MasterCell.self, forCellReuseIdentifier: MasterCell.cell)
        tableView.register(LoadingCell.self, forCellReuseIdentifier: LoadingCell.cell)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func timerForConnection() {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] timer in
            guard let self = self else {return}
            if !self.mainArray.isEmpty {
                timer.invalidate()
            }
            self.timerCount += 1
            if self.timerCount == 15{
                if self.mainArray.isEmpty {
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
            self.mainArray = data.news
            for i in 0..<5 {
                self.array.append(self.mainArray[i])
            }
            DispatchQueue.main.async {
                self.activityView.stopAnimating()
                self.tableView.reloadData()
                self.backgroundView.isHidden = false
            }
            self.isLoadingData = false
        }
    }
    
    private func getMoreData() {
        if array.count == mainArray.count {return}
        if !self.isLoadingData {
            self.isLoadingData = true
            let start = array.count
            let end = start + 5
            DispatchQueue.global().async {
                sleep(2)
                for i in start..<end {
                    self.array.append(self.mainArray[i])
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
        if (offsetY > contentHeight - scrollView.frame.height * 4) && !isLoadingData  && array.count != mainArray.count {
            getMoreData()
        }
    }
}
//MARK: - TableViewDataSource configure
extension MasterViewController: UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            if searchCont.isActive && searchCont.searchBar.text != "" {
                if filteredArray.count > 0 {
                    self.tableView.backgroundView = .none;
                    return filteredArray.count
                } else {
                    self.tableView.backgroundView = backgroundView
                    backgroundView.text = "No results"
                    return 0
                }
            } else {
                if array.count > 0 {
                    self.tableView.backgroundView = .none;
                    return array.count
                } else {
                    self.tableView.backgroundView = backgroundView
                    backgroundView.text = "No results"
                    return 0
                }
            }
        } else if section == 1 {
            return 1
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MasterCell.cell, for: indexPath) as? MasterCell else {
                return UITableViewCell()
            }
            if !isFiltered {
                cell.configure(data: array, indexPath: indexPath, cell: cell)
            } else {
                cell.configure(data: filteredArray, indexPath: indexPath, cell: cell)
            }
            return cell
        } else {
            if array.count != mainArray.count {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: LoadingCell.cell, for: indexPath) as? LoadingCell else {
                    return UITableViewCell()
                }
                if !isFiltered {
                    cell.activityInd.isHidden = false
                    cell.activityInd.startAnimating()
                } else {
                    cell.activityInd.isHidden = true
                }
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
            if array.count != mainArray.count {
                return 30
            } else {
                return 0
            }
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
        filteredArray = array.filter {
            $0.author.lowercased().contains(searchController.searchBar.text?.lowercased() ?? "")
        }
        tableView.reloadData()
    }
//MARK: - didSelectRow configure -
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if !isFiltered {
            pushSelectedViewController(array: array, indexPath: indexPath)
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
