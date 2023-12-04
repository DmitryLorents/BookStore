//
//  CollectionViewFactory.swift
//  BookStore
//
//  Created by Максим Горячкин on 04.12.2023.
//

import UIKit.UICollectionView

protocol CollectionViewFactoryProtocol {
    func createCollectionView(with layout: UICollectionViewFlowLayout) -> UICollectionView
}

class CollectionViewFactory: CollectionViewFactoryProtocol {
    func createCollectionView(with layout: UICollectionViewFlowLayout) -> UICollectionView {
        lazy var mainCollectionView: UICollectionView = {
            let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
            view.backgroundColor = .cyan
            view.showsVerticalScrollIndicator = false
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
        }()
        
        return mainCollectionView
    }
}
