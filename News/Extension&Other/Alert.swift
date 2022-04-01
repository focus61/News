import UIKit
struct Alert {
    static func show(_ vc: UIViewController) {
        let alertCont = UIAlertController(title: "Warning", message: "Check your connection", preferredStyle: .alert)
        let alertAct = UIAlertAction(title: "Cancel", style: .destructive) { _ in
            exit(2)
        }
        alertCont.addAction(alertAct)
        vc.present(alertCont, animated: true, completion: nil)
    }
}
