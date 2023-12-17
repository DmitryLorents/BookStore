//
//  BookSectionDataSource.swift
//  BookStore
//
//  Created by Максим Горячкин on 05.12.2023.
//

import UIKit

final class BookSectionDataSource {
    private let collectionView: UICollectionView
    private let dataSource: DataSource
//    
//    var dataModel = DataModel()
//    
//    struct DataModel {
//        let topHeader: HomeViewModel.Button
//        let topBooks: [Book]
//        
//        init(
//            topHeader: HomeViewModel.Button = .init(title: "", action: {}),
//            topBooks: [Book] = .init()
//        ) {
//            self.topHeader = topHeader
//            self.topBooks = topBooks
//        }
//    }
    
    //MARK: - init(_:)
    init(_ collectionView: UICollectionView) {
        self.collectionView = collectionView
        dataSource = .init(collectionView: collectionView) { collectionView, indexPath, item in
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: item.identifier,
                for: indexPath
            )
            
            switch item {
            case .categories(let category):
                let cell = cell as? CategoryCell
                cell?.configure(with: category)
            case .top(let book):
                let cell = cell as? BookCell
                cell?.configure(with: book)
            case .recent(let book):
                let cell = cell as? BookCell
                cell?.configure(with: book)
            }
            
            return cell
        }
        
        registerCells()
        collectionView.dataSource = dataSource
    }
    
    //MARK: - Public methods
    func update(categoryModels: [CategoryViewModel], topBooks: [Book] = [], recentBooks: [Book] = []) {
        var snapshot = DataSnapshot()
        let sections = BookSection.allCases
        snapshot.appendSections(sections)
        snapshot.appendItems(
            categoryModels.map(Item.categories),
            toSection: .categories
        )
        snapshot.appendItems(
            topBooks.map(Item.top),
            toSection: .top
        )
        snapshot.appendItems(
            recentBooks.map(Item.recent),
            toSection: .recent
        )
        
        snapshot.reloadSections(sections)
        dataSource.apply(snapshot)
    }
    
    func updateHeader(with model: HomeViewModel) {
        dataSource.supplementaryViewProvider = nil
        
        let supplementary: DataSource.SupplementaryViewProvider = { collectionView, kind, indexPath in
            let header = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: SectionHeaderView.identifier,
                for: indexPath
            ) as? SectionHeaderView
            
            switch BookSection(rawValue: indexPath.section) {
            case .categories:
                header?.configure(with: model.topBooksHeader.title,
                                  buttonTitle: model.topBooksHeader.button.title,
                                  tapAction: model.topBooksHeader.button.action)
            case .top:
                header?.configure(with: "", buttonTitle: "", tapAction: {})
            case .recent:
                header?.configure(with: model.recentBooksHeader.title, 
                                  buttonTitle: model.recentBooksHeader.button.title,
                                  tapAction: model.recentBooksHeader.button.action)
            default:
                assertionFailure("Unknown header type!")
            }
            
            return header
        }
        
        dataSource.supplementaryViewProvider = supplementary
        
    }
    
}

private extension BookSectionDataSource {
    typealias DataSource = UICollectionViewDiffableDataSource<BookSection, Item>
    typealias DataSnapshot = NSDiffableDataSourceSnapshot<BookSection, Item>
    
    func registerCells() {
        collectionView.register(
            BookCell.self,
            forCellWithReuseIdentifier: BookCell.identifier
        )
        collectionView.register(
            CategoryCell.self,
            forCellWithReuseIdentifier: CategoryCell.identifier
        )
        collectionView.register(
            SectionHeaderView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: SectionHeaderView.identifier
        )
    }
 
    enum Item: Hashable {
        case categories(CategoryViewModel)
        case top(Book)
        case recent(Book)
        
        var identifier: String {
            switch self {
            case .categories: return CategoryCell.identifier
            case .recent, .top: return BookCell.identifier
            }
        }
    }
}
