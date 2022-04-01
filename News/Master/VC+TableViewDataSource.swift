
import UIKit
//MARK: - TableViewDataSource configure -
    extension MasterViewController: UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating {
        func numberOfSections(in tableView: UITableView) -> Int {
            var numOfSections: Int = 0
            if searchCont.isActive && !(searchCont.searchBar.text?.isEmpty ?? false) {
                numOfSections = noResultLabel(isHaveData: !filteredArray.isEmpty, tableView: tableView)
            } else {
                numOfSections = noResultLabel(isHaveData: !nonFilteredArray.isEmpty, tableView: tableView)
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
