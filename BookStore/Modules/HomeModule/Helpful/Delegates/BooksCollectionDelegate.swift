//
//  BooksCollectionDelegate.swift
//  BookStore
//
//  Created by Шаповалов Илья on 11.12.2023.
//

import UIKit

final class BooksCollectionDelegate: NSObject, UICollectionViewDelegate {
    private let collectionView: UICollectionView
    
    var didSelectCategoryAt: ((Int) -> Void)?
    var didSelectTopAt: ((Int) -> Void)?
    var didSelectRecentAt: ((Int) -> Void)?
    
    init(_ collectionView: UICollectionView) {
        self.collectionView = collectionView
        super.init()
        collectionView.delegate = self
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        switch BookSection(rawValue: indexPath.section) {
        case .categories:
            didSelectCategoryAt?(indexPath.item)
        case .top:
            didSelectTopAt?(indexPath.item)
        case .recent:
            didSelectRecentAt?(indexPath.item)
        case .none:
            print("error")
            return
        }
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        willDisplay cell: UICollectionViewCell,
        forItemAt indexPath: IndexPath
    ) {
        
    }

}
