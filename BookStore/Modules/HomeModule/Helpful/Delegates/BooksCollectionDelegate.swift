//
//  BooksCollectionDelegate.swift
//  BookStore
//
//  Created by Максим Горячкин on 12.12.2023.
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch BookSection(rawValue: indexPath.section) {
        case .categories:
            let cells = collectionView.visibleCells.map { $0 as? CategoryCell }
            cells.forEach { $0?.resetCell() }
            let cell = collectionView.cellForItem(at: indexPath) as? CategoryCell
            cell?.checkCell()
        case .top:
            print("didSelectTopAt?\(indexPath.item)")
            didSelectTopAt?(indexPath.item)
        case .recent:
            print("didSelectRecentAt?\(indexPath.item)")
            didSelectRecentAt?(indexPath.item)
        case .none:
            print("error")
            return
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath
    ) {
        
    }

}
