//
//  UIView + ext.swift
//  BookStore
//
//  Created by Максим Горячкин on 04.12.2023.
//

import UIKit.UIView

extension UIView {
    func addSomeSubviews(views: UIView...) {
        views.forEach {
            self.addSubview($0)
        }
    }
}
