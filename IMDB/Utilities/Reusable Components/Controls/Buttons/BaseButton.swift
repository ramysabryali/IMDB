//
//  BaseButton.swift
//  IMDB
//
//  Created by Ramy Sabry on 23/04/2022.
//

import UIKit

@IBDesignable
final class BaseButton: UIButton {
    @objc enum CustomStyle: Int {
        case primary = 0
        case seconday = 1
        
        var backgroundColor: UIColor {
            self == .primary ? UIColor.Core.yelloColor : UIColor.Controls.BaseButton.secondaryButtonColor
        }
        
        var titleColor: UIColor {
            self == .primary ? UIColor.Core.constantBlackColor : UIColor.Controls.BaseButton.SecondaryButtonTitleColor
        }
        
        var borderColor: UIColor {
            self == .primary ? UIColor.Core.yelloColor : UIColor.Controls.BaseButton.SecondaryButtonBorderColor
        }
    }
    
    @IBInspectable
    var customStyle: CustomStyle = .primary {
        didSet {
            applyStyle()
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        setup()
    }

    private func setup() {
        clipsToBounds = true
        layer.cornerRadius = 5
        setConstraint()
        applyStyle()
    }
    
    private func setConstraint() {
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func applyStyle() {
        backgroundColor = customStyle.backgroundColor
        titleLabel?.textColor = customStyle.titleColor
        layer.borderColor = customStyle.borderColor.cgColor
        layer.borderWidth = 1.5
    }
}
