//
//  ResultsViewController.swift
//  RainbowApp
//
//  Created by Nikita Savchik on 15/11/2023.
//

import UIKit

class CategoriesViewController: UIViewController {
    
    
    //MARK: - Private Parameters
    
    private let categoriesView = CategoriesView()
    private let data = CategoriesModel.data
    
    //MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = categoriesView
        categoriesView.transferDelegates(dataSource: self, delegate: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        categoriesView.setupCollectionLayout(layout: createLayoutForCollection())
    }
    
    //MARK: - Private Methods
    
    private func createLayoutForCollection() -> UICollectionViewFlowLayout {

        let layout = UICollectionViewFlowLayout()
        let basicSpacing: CGFloat = 20
        let itemsPerRow: CGFloat = 2
        let paddingWidth = basicSpacing * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingWidth
        let widthPerItem = availableWidth / itemsPerRow
        layout.minimumLineSpacing = basicSpacing
        layout.minimumInteritemSpacing = basicSpacing
        layout.sectionInset = UIEdgeInsets(top: 0, left: basicSpacing, bottom: 0, right: basicSpacing)
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: widthPerItem, height: widthPerItem * 0.66)
        return layout
    }
}
    //MARK: - Extencion for ViewCollection Protocols
    
    extension CategoriesViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
        
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return data.count
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCustomCell.reuseID, for: indexPath) as? CategoryCustomCell else { fatalError() }
            cell.data = self.data[indexPath.item]
            return cell
        }
    }

