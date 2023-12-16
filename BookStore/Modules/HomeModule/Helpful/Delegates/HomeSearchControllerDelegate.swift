//
//  HomeSearchControllerDelegate.swift
//  BookStore
//
//  Created by Максим Горячкин on 12.12.2023.
//

import UIKit

class HomeSearchControllerDelegate: NSObject, UISearchControllerDelegate, UISearchBarDelegate {
    private let searchController: UISearchController
    private let presenter: HomePresenterProtocol
    
    var didTapCancel: ((Int) -> Void)?
    
    init(searchController: UISearchController, presenter: HomePresenterProtocol) {
        self.searchController = searchController
        self.presenter = presenter
        super.init()
        searchController.delegate = self
        searchController.searchBar.delegate = self
    }
    
    func check() {
        print("TEST")
    }
    
    func willDismissSearchController(_ searchController: UISearchController) {
        presenter.willDismissSearchController()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchController.searchBar.text = ""
        searchController.searchBar.resignFirstResponder()
        presenter.searchBarCancelButtonClicked()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else { return }
        presenter.searchBarSearchButtonClicked(text)
    }

}

