//
//  DataBuilder.swift
//  BookStore
//
//  Created by Максим Горячкин on 05.12.2023.
//

import UIKit

final class DataBuilder {
    func createDataSource(for collectionView: UICollectionView, from sections: [BookSection]) -> UICollectionViewDiffableDataSource<BookSection, AnyHashable> {
        let dataSource = UICollectionViewDiffableDataSource<BookSection, AnyHashable>(collectionView: collectionView) { collectionView, indexPath, item in
            switch item {
            case let model as Book:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCollectionViewCell.identifier, for: indexPath) as! CustomCollectionViewCell
                cell.configure(with: model)
                return cell
            case let model as Categorie:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCollectionViewCell.identifier, for: indexPath) as! CategoryCollectionViewCell
                cell.configure(with: model)
                return cell
            default:
                fatalError("Unknown item type")
            }
        }
        
        updateDataSource(for: dataSource, from: sections)
        updateHeader(for: dataSource, from: sections)

        return dataSource
    }
    
    func updateDataSource(for dataSource: UICollectionViewDiffableDataSource<BookSection, AnyHashable>, from sections: [BookSection]) {
        var snapshot = NSDiffableDataSourceSnapshot<BookSection, AnyHashable>()
        snapshot.appendSections(sections)
        
        sections.forEach { section in
            switch section {
            case .categories(title: _, buttonTitle: _, name: let name):
                snapshot.appendItems(name, toSection: section)
            case .top(books: let books, isHidden: _):
                snapshot.appendItems(books, toSection: section)
            case .recent(title: _, buttonTitle: _, books: let books, isHidden: _):
                snapshot.appendItems(books, toSection: section)
            }
        }
        
        dataSource.apply(snapshot)
    }
    
    func updateHeader(for dataSource: UICollectionViewDiffableDataSource<BookSection, AnyHashable>, from sections: [BookSection]) {
        dataSource.supplementaryViewProvider = { collectionView, kind, indexPath in
            guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SectionHeader.identifier, for: indexPath) as? SectionHeader else { return nil }
            
            switch sections[indexPath.section] {
            case .categories(title: let title, buttonTitle: let buttonTitle, name: _):
                header.configure(with: title, subtitle: buttonTitle)
                return header
            case .top(books: _, isHidden: _):
                return header
            case .recent(title: let title, buttonTitle: let buttonTitle, books: _, isHidden: _):
                header.configure(with: title, subtitle: buttonTitle)
                return header
            }
        }
    }
    
    func supplementary(collectionView: UICollectionView, kind: String, indexPath: IndexPath) -> UICollectionReusableView? {
        switch kind {
        case SectionHeader.identifier:
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SectionHeader.identifier, for: indexPath) as? SectionHeader
            return header

        default:
            assertionFailure("Handle new kind")
            return nil
        }
    }
}
