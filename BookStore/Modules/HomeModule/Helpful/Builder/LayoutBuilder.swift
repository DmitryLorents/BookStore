//
//  LayoutBuilder.swift
//  BookStore
//
//  Created by Максим Горячкин on 04.12.2023.
//

import UIKit

final class LayoutBuilder {
    func createLayout() -> UICollectionViewLayout {
        let sections = BookSection.allCases
        let layout = UICollectionViewCompositionalLayout { sectionIndex, _ in
            switch sections[sectionIndex] {
            case .categories:
                return LayoutBuilder().createCategorySection()
            case .top:
                return LayoutBuilder().createTopBooksSection(header: true)
            case .recent:
                return LayoutBuilder().createTopBooksSection(header: false)
            }
        }
        return layout
    }

    private func createTopBooksSection(header isHidden: Bool) -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 12)
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(176), heightDimension: .absolute(235))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 12.0, leading: 12.0, bottom: 12.0, trailing: 12.0)
        section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
        
        let header = createHeader()
        section.boundarySupplementaryItems = !isHidden ? [header] : []
        return section
    }
    
    private func createCategorySection() -> NSCollectionLayoutSection {
        let estimatedHeight: CGFloat = 32
        let estimatedWidth: CGFloat = 86
        let size = NSCollectionLayoutSize(widthDimension: .estimated(estimatedWidth),
                                          heightDimension: .estimated(estimatedHeight))
        let item = NSCollectionLayoutItem(layoutSize: size)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: size,
                                                       subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 8
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = NSDirectionalEdgeInsets(top: 12, leading: 12, bottom: 12, trailing: 12)
        
        let header = createHeader()
        section.boundarySupplementaryItems = [header]
        return section
    }
    
    private func createHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(40))
        let layout = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: itemSize,
                                                                 elementKind: UICollectionView.elementKindSectionHeader,
                                                                 alignment: .top)
        return layout
    }
    
}
