//
//  UILabel + ext.swift
//  BookStore
//
//  Created by Максим Горячкин on 13.12.2023.
//

import UIKit.UILabel

extension UILabel {
    static func common(_ font: UIFont, numberOfLines: Int = 0) -> UILabel {
        let view = UILabel()
        view.numberOfLines = numberOfLines
        view.font = font
        view.textColor = .white
        view.textAlignment = .left
        return view
    }
}
