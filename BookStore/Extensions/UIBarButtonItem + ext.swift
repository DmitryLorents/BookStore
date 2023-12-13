//
//  UIBarButtonItem + ext.swift
//  BookStore
//
//  Created by Максим Горячкин on 13.12.2023.
//

import UIKit.UIBarButtonItem

extension UIBarButtonItem {
    static func createGlassItem(_ selector: Selector) -> UIBarButtonItem {
        UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"),
                                             style: .done,
                                             target: self,
                                             action: selector)
    }
}
