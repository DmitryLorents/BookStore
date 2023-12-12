//
//  HomeSearchControllerDelegate.swift
//  BookStore
//
//  Created by Максим Горячкин on 12.12.2023.
//

import UIKit

class HomeSearchControllerDelegate: NSObject, UISearchControllerDelegate {
    private let searchController: UISearchController
    private let navigationController: UINavigationController?
    
    var didTapGlass: ((Int) -> Void)?
    var didTapCancel: ((Int) -> Void)?
    
    init(searchController: UISearchController, navigationController: UINavigationController?) {
        self.searchController = searchController
        self.navigationController = navigationController
        super.init()
        searchController.delegate = self
    }
    
    func check() {
        print("test")
    }
    
    func willDismissSearchController(_ searchController: UISearchController) {
        navigationController?.navigationItem.searchController = nil
        navigationController?.view.layoutIfNeeded()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchController.searchBar.text = ""
        searchController.searchBar.resignFirstResponder()
        searchController.dismiss(animated: true, completion: nil)
    }
}

