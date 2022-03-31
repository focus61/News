import UIKit
extension UIView {
    func addSubviews(views: UIView...) {
        for i in views {
            i.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(i)
        }
    }
    func addBottomBorder(color: UIColor = UIColor.red, margins: CGFloat = 0, borderLineSize: CGFloat = 1) {
               let border = UIView()
               border.backgroundColor = color
               border.translatesAutoresizingMaskIntoConstraints = false
               self.addSubview(border)
               border.addConstraint(NSLayoutConstraint(item: border,
                                                       attribute: .height,
                                                       relatedBy: .equal,
                                                       toItem: nil,
                                                       attribute: .height,
                                                       multiplier: 1, constant: borderLineSize))
               self.addConstraint(NSLayoutConstraint(item: border,
                                                     attribute: .bottom,
                                                     relatedBy: .equal,
                                                     toItem: self,
                                                     attribute: .bottom,
                                                     multiplier: 1, constant: 0))
               self.addConstraint(NSLayoutConstraint(item: border,
                                                     attribute: .leading,
                                                     relatedBy: .equal,
                                                     toItem: self,
                                                     attribute: .leading,
                                                     multiplier: 1, constant: margins))
               self.addConstraint(NSLayoutConstraint(item: border,
                                                     attribute: .trailing,
                                                     relatedBy: .equal,
                                                     toItem: self,
                                                     attribute: .trailing,
                                                     multiplier: 1, constant: margins))
        }
    func addLeftBorder(with color: UIColor?, andWidth borderWidth: CGFloat) {
        let border = UIView()
        border.backgroundColor = color
        border.frame = CGRect(x: 0, y: 0, width: borderWidth, height: frame.size.height - 10)
        border.autoresizingMask = [.flexibleHeight, .flexibleRightMargin]
        addSubview(border)
    }
    func addRightBorder(with color: UIColor?, andWidth borderWidth: CGFloat) {
        let border = UIView()
        border.backgroundColor = color
        border.frame = CGRect(x: frame.size.width - borderWidth + 5, y: 0, width: borderWidth, height: frame.size.height)
        border.autoresizingMask = [.flexibleHeight, .flexibleLeftMargin]
        addSubview(border)
    }
}

