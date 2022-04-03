import UIKit
//MARK: - Get data and infinite scroll -
extension MasterViewController {
    public func getData() {
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
