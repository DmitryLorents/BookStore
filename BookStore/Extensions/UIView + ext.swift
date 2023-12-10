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
    
    func rotate(angle: CGFloat) {
        let radians = angle / 180.0 * CGFloat.pi
        let rotation = CGAffineTransformRotate(self.transform, radians);
        self.transform = rotation
    }
}
