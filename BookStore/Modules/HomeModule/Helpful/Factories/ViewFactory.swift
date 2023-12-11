//
//  CollectionViewFactory.swift
//  BookStore
//
//  Created by Максим Горячкин on 04.12.2023.
//

import UIKit.UICollectionView

final class ViewFactory {
    func createCollectionView(with layout: UICollectionViewLayout) -> UICollectionView {
        lazy var mainCollectionView: UICollectionView = {
            let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
            view.backgroundColor = .systemBackground
            view.showsVerticalScrollIndicator = false
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
        }()
        
        return mainCollectionView
    }
    
    func createSearchBarView() -> UISearchBar {
        let searchBar: UISearchBar = {
            let view = UISearchBar()
            view.tintColor = UIColor.black.withAlphaComponent(1.0)
            view.placeholder = "Enter book title..."
            view.backgroundColor = UIColor.clear
            view.barTintColor = UIColor.clear
            view.searchBarStyle = .minimal
            view.returnKeyType = .search
            view.showsCancelButton = true
            view.showsBookmarkButton = true
            view.sizeToFit()
            return view
        }()
        
        return searchBar
    }
}
