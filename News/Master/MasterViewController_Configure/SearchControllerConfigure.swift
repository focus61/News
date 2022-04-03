import UIKit
//MARK: - Search configure -
extension MasterViewController {
     func searchConfig() {
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
