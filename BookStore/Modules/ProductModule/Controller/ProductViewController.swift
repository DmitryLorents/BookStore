//
//  ProductViewController.swift
//  BookStore
//
//  Created by Andrei Shpartou on 5/12/2023.
//

import UIKit

class ProductViewController: UIViewController {
    //MARK: - Parameters
    private let productView = ProductView()
    
    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view = productView
        
        setupNavigationBar()
    }
    
    //MARK: - Methods
    private func setupNavigationBar() {
        let navBar = navigationController?.navigationBar
        navBar?.tintColor = .black
        // backButton
        navBar?.backIndicatorImage = UIImage(systemName: "arrow.left")
        navBar?.backIndicatorTransitionMaskImage = UIImage(systemName: "arrow.left")
        navBar?.topItem?.backButtonTitle = ""
        // likeButton
        let isFavourite = checkFavoriteStatus()
        updateFavouriteBarButton(isFavourite)
    }
    
    private func updateFavouriteBarButton(_ isFavourite: Bool) {
        
        let favouriteButton = UIButton(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        
        if isFavourite {
            favouriteButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            favouriteButton.addTarget(self, action: #selector(revomeFromFavourite), for: .touchUpInside)
        } else {
            favouriteButton.setImage(UIImage(systemName: "heart"), for: .normal)
            favouriteButton.addTarget(self, action: #selector(addToFavourite), for: .touchUpInside)
        }
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: favouriteButton)
    }
    
    private func checkFavoriteStatus() -> Bool {
        return false
    }
    
    @objc private func addToFavourite() {
        // add to favourites logic
        updateFavouriteBarButton(true)
    }
    
    @objc private func revomeFromFavourite() {
        // remove from favourites logic
        updateFavouriteBarButton(false)
    }
}
