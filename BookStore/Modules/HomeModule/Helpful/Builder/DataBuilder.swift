//
//  DataBuilder.swift
//  BookStore
//
//  Created by Максим Горячкин on 05.12.2023.
//

import UIKit

final class DataBuilder {
    typealias DataSource = UICollectionViewDiffableDataSource<BookSection, AnyHashable>
    
    let sections = BookSection.allCases
    
    func createDataSource(for collectionView: UICollectionView, from topBooks: [Book], and recentBooks: [Book]) -> DataSource {
        let dataSource = UICollectionViewDiffableDataSource<BookSection, AnyHashable>(collectionView: collectionView) { collectionView, indexPath, item in
            switch item {
            case let model as Book:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCollectionViewCell.identifier, for: indexPath) as! CustomCollectionViewCell
                cell.configure(with: model)
                return cell
            case let model as HomeCategory:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCollectionViewCell.identifier, for: indexPath) as! CategoryCollectionViewCell
                cell.configure(with: model)
                return cell
            default:
                fatalError("Unknown item type")
            }
        }
        
        updateDataSource(dataSource, topBooks: topBooks, recentBooks: recentBooks)
        updateHeader(for: dataSource)
        
        return dataSource
    }
    
    func updateDataSource(_ dataSource: DataSource, topBooks: [Book], recentBooks: [Book]) {
        var snapshot = NSDiffableDataSourceSnapshot<BookSection, AnyHashable>()
        snapshot.appendSections(sections)
        
        sections.forEach { section in
            switch section {
            case .categories:
                snapshot.appendItems(HomeCategory.allCases, toSection: section)
            case .top:
                snapshot.appendItems(topBooks, toSection: section)
            case .recent:
                snapshot.appendItems(recentBooks, toSection: section)
            }
        }
        
        dataSource.apply(snapshot)
        
    }
    
    
    func updateHeader(for dataSource: DataSource) {
        dataSource.supplementaryViewProvider = { collectionView, kind, indexPath in
            if let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SectionHeader.identifier, for: indexPath) as? SectionHeader {
                
                switch self.sections[indexPath.section] {
                case .categories:
                    header.configure(with: "Top Books")
                    return header
                case .top:
                    header.configure(with: "")
                    return header
                case .recent:
                    header.configure(with: "Recent Books")
                    return header
                }
            }
            return nil
        }
    }
}
