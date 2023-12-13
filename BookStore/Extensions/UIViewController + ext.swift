//
//  UIViewController + ext.swift
//  BookStore
//
//  Created by Максим Горячкин on 12.12.2023.
//

import UIKit

extension UIViewController {
    static var homeBuilder: UIViewController {
        let searchController = UISearchController(searchResultsController: SearchViewController())
        searchController.showsSearchResultsController = true
        let presenter = HomePresenter()
        let homeViewController = HomeViewController(
            presenter: presenter,
            searchController: searchController
        )
        presenter.view = homeViewController
        return homeViewController
    }
}

