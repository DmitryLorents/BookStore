//
//  UICollectionView + ext.swift
//  BookStore
//
//  Created by Максим Горячкин on 04.12.2023.
//

import UIKit.UICollectionView

extension UICollectionView {
    static func createCollectionView(with layout: UICollectionViewLayout) -> UICollectionView {
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = .systemBackground
        view.showsVerticalScrollIndicator = false
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
}
