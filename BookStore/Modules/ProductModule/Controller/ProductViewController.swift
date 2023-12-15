//
//  ProductViewController.swift
//  BookStore
//
//  Created by Andrei Shpartou on 5/12/2023.
//

import UIKit

class ProductViewController: UIViewController {
    //MARK: - Parameters
    private var book: Book?
    private let storageManager = StorageManagerRealm.shared
    private let productView = ProductView()
    
    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = productView
        setupNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        productView.setVIewsData(book: book)
    }
    
    //MARK: - Init
    
    init(book: Book? = nil) {
        self.book = book
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
        guard let book else {return false}
        return storageManager.checkDublicateBook(book)
    }
    
    @objc private func addToFavourite() {
        guard let book else {return}
        storageManager.saveBook(book)
        updateFavouriteBarButton(true)
    }
    
    @objc private func revomeFromFavourite() {
        guard let book else {return}
        storageManager.deleteBook(withBook: book)
        updateFavouriteBarButton(false)
    }
}
