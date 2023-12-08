//
//  GradientView.swift
//  BookStore
//
//  Created by Igor Guryan on 08.12.2023.
//

import UIKit

class GradientView: UIView {
    var topColor: CGColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1).cgColor
    var bottomColor: CGColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3).cgColor
    override class var layerClass: AnyClass {
        return CAGradientLayer.self
    }

    override func layoutSubviews() {
        (layer as! CAGradientLayer).colors = [topColor, bottomColor]
        (layer as! CAGradientLayer).locations = [0.0, 1.0]
    }
}
