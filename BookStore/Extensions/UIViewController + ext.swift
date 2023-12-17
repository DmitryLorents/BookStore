//
//  UIViewController + ext.swift
//  BookStore
//
//  Created by Максим Горячкин on 12.12.2023.
//

import UIKit

extension UIViewController {
    static var homeBuilder: UIViewController {
        let searchResultsController = CartViewController(books: nil, titleCart: "")
        let searchController = UISearchController(searchResultsController: searchResultsController)
        searchController.showsSearchResultsController = true
        let presenter = HomePresenter()
        let homeViewController = HomeViewController(
            presenter: presenter,
            searchController: searchController
        )
        presenter.view = homeViewController
        presenter.searchView = searchResultsController
        return homeViewController
    }
}

