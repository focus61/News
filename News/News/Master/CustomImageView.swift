import UIKit
class CustomImageView: UIImageView {
    var task: URLSessionDataTask?
    var activity = UIActivityIndicatorView(style: .large)
    func loadImage(url: URL) {
        image = nil
        addActivity()
        if let task = task {
            task.cancel()
        }
        if let imageFromCache = MasterCell.imageCahce.object(forKey: url.absoluteString as AnyObject) as? UIImage {
            image = imageFromCache
            removeActivity()
            return
        }
        task = URLSession.shared.dataTask(with: url) { [weak self] data, _, err in
            guard let data = data, let image = UIImage(data: data) else {
                return
            }
            MasterCell.imageCahce.setObject(image, forKey: url.absoluteString as AnyObject)
            DispatchQueue.main.async {
                self?.image = image
                self?.removeActivity()
            }
        }
        self.task?.resume()
    }
    func addActivity() {
        addSubview(activity)
        activity.translatesAutoresizingMaskIntoConstraints = false
        activity.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        activity.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        activity.startAnimating()
    }
    func removeActivity() {
        activity.removeFromSuperview()
    }
}
