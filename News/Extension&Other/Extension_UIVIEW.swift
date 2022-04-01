import UIKit
extension UIView {
    func addSubviews(views: UIView...) {
        for i in views {
            i.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(i)
        }
    }
    
    func addRightBorder(with color: UIColor?, andWidth borderWidth: CGFloat) {
        let border = UIView()
        border.backgroundColor = color
        border.frame = CGRect(x: frame.size.width - borderWidth + 5, y: 0, width: borderWidth, height: frame.size.height)
        border.autoresizingMask = [.flexibleHeight, .flexibleLeftMargin]
        addSubview(border)
    }
}

