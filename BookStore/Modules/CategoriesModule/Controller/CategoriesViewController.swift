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
}
    //MARK: - Private Methods
    
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


    #Preview { CategoriesViewController() }


//func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//    guard let cell = tableView.dequeueReusableCell(withIdentifier: CartViewCell.reuseID, for: indexPath) as? CartViewCell else { fatalError() }
//
//    cell.configureCell(likeBook: likeArray[indexPath.row])
//    return cell
//}
