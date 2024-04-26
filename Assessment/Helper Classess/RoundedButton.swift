//
// RoundedButton.swift
//  Assessment
//
//  Created by apple on 27/04/24.
//

import UIKit

@IBDesignable
extension UIView {
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        get {
            return UIColor(cgColor: layer.borderColor!)
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
    
    func animationLeftToRight() {
        let transition = CATransition()
        transition.duration = 0.5
        transition.type = CATransitionType.moveIn
        transition.subtype = CATransitionSubtype.fromLeft
        transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
        self.layer.add(transition, forKey: kCATransition)
    }
    
    func animationRightToLeft() {
        let transition = CATransition()
        transition.duration = 0.5
        transition.type = CATransitionType.moveIn
        transition.subtype = CATransitionSubtype.fromRight
        transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
        self.layer.add(transition, forKey: kCATransition)
    }
    
    func constrainToEdges(_ subview: UIView) {
        subview.translatesAutoresizingMaskIntoConstraints = false

        let topContraint = NSLayoutConstraint(
            item: subview,
            attribute: .top,
            relatedBy: .equal,
            toItem: self,
            attribute: .top,
            multiplier: 1.0,
            constant: 0
        )

        let bottomConstraint = NSLayoutConstraint(
            item: subview,
            attribute: .bottom,
            relatedBy: .equal,
            toItem: self,
            attribute: .bottom,
            multiplier: 1.0,
            constant: 0
        )

        let leadingContraint = NSLayoutConstraint(
            item: subview,
            attribute: .leading,
            relatedBy: .equal,
            toItem: self,
            attribute: .leading,
            multiplier: 1.0,
            constant: 0
        )

        let trailingContraint = NSLayoutConstraint(
            item: subview,
            attribute: .trailing,
            relatedBy: .equal,
            toItem: self,
            attribute: .trailing,
            multiplier: 1.0,
            constant: 0
        )

        addConstraints([
            topContraint,
            bottomConstraint,
            leadingContraint,
            trailingContraint,
        ])
    }
    
    func constrainCentered(_ subview: UIView) {
        subview.translatesAutoresizingMaskIntoConstraints = false

        let verticalContraint = NSLayoutConstraint(
            item: subview,
            attribute: .centerY,
            relatedBy: .equal,
            toItem: self,
            attribute: .centerY,
            multiplier: 1.0,
            constant: 0
        )

        let horizontalContraint = NSLayoutConstraint(
            item: subview,
            attribute: .centerX,
            relatedBy: .equal,
            toItem: self,
            attribute: .centerX,
            multiplier: 1.0,
            constant: 0
        )

        let heightContraint = NSLayoutConstraint(
            item: subview,
            attribute: .height,
            relatedBy: .equal,
            toItem: nil,
            attribute: .notAnAttribute,
            multiplier: 1.0,
            constant: subview.frame.height
        )

        let widthContraint = NSLayoutConstraint(
            item: subview,
            attribute: .width,
            relatedBy: .equal,
            toItem: nil,
            attribute: .notAnAttribute,
            multiplier: 1.0,
            constant: subview.frame.width
        )

        addConstraints([
            horizontalContraint,
            verticalContraint,
            heightContraint,
            widthContraint,
        ])
    }
    
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let maskPath = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = bounds
        maskLayer.path = maskPath.cgPath
        layer.mask = maskLayer
    }
}


@IBDesignable
class localizeButton: UIButton {
    @IBInspectable var localizableText: String = "" {
        didSet {
            let attributedTitle = NSAttributedString(string: localizableText.localize(), attributes: [.font: self.titleLabel?.font ?? UIFont(name: "NunitoSans-Regular", size: 14)!])
            self.setAttributedTitle(attributedTitle, for: .normal)
        }
    }
}

extension String {
    func localize() -> String {
        if let lang = UserDefaults.standard.object(forKey: "languageCode") {
            let path = Bundle.main.path(forResource: lang as? String, ofType: "lproj")
            let bundle = Bundle(path: path!)
            return NSLocalizedString(self, tableName: nil, bundle: bundle!, value: "", comment: "")
        }
        return self
    }
    
    var htmlToAttributedString: NSMutableAttributedString? {
        guard let data = data(using: .utf8) else { return nil }
        do {
            return try NSMutableAttributedString(data: data,
                                                 options: [.documentType: NSMutableAttributedString.DocumentType.html,
                                                           .characterEncoding: String.Encoding.utf8.rawValue],
                                                 documentAttributes: nil)
        } catch let error as NSError {
            print(error.localizedDescription)
            return  nil
        }
    }
    
    func removeHTMLTag() -> String {
        let str = self.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
        let str1 = str.replacingOccurrences(of: "&nbsp;", with: " ")
        return str1.replacingOccurrences(of: "&#39;", with: "'")
    }
}

class ButtonWithImage: UIButton {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if imageView != nil {
            titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: (imageView?.frame.width)!)
            let position = (titleLabel?.frame.width ?? 0) + (titleLabel?.frame.origin.x ?? 0) + 5
            imageEdgeInsets = UIEdgeInsets(top: 5, left: position, bottom: 5, right: 5)
        }
    }
}

extension UILabel {
    func setSemiBoldAndNormalText(semiBoldText: String, normalText: String) {
        let attributedString = NSMutableAttributedString()
        let semiBoldAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 15, weight: .semibold)
        ]
        let semiBoldAttributedString = NSAttributedString(string: semiBoldText, attributes: semiBoldAttributes)
        attributedString.append(semiBoldAttributedString)
        let normalAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 15, weight: .regular)
        ]
        let normalAttributedString = NSAttributedString(string: normalText, attributes: normalAttributes)
        attributedString.append(normalAttributedString)
        self.attributedText = attributedString
    }
}
