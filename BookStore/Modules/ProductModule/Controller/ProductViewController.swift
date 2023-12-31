//
//  ProductViewController.swift
//  BookStore
//
//  Created by Andrei Shpartou on 5/12/2023.
//

import UIKit
import SafariServices

class ProductViewController: UIViewController {
    //MARK: - Parameters
    private var book: Book?
    private let storageManager = StorageManagerRealm.shared
    private let productView = ProductView()
    
    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = productView
        productView.setVIewsData(book: book)
        setupNavigationBar()
        saveToRecent()
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
    
    private func saveToRecent() {
        guard let book else {return}
        storageManager.addToRecent(book)
    }
    
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
        return storageManager.checkDublicateBook(book, isFavorite: true)
    }
    
    @objc private func addToFavourite() {
        guard let book else {return}
        storageManager.addToFavorites(book)
        updateFavouriteBarButton(true)
    }
    
    @objc private func revomeFromFavourite() {
        guard let book else {return}
        storageManager.deleteBook(book)
        updateFavouriteBarButton(false)
    }
    
    @objc func openBookWebPage() {
        guard let key = book?.key else {return}
        let descriptionURL = OpenLibraryEndpoints.returnDescriptionURL(key: key)
        let webController = SFSafariViewController(url: descriptionURL)
        present(webController, animated: true)
    }
    
    @objc func addBookToList() {
        guard let book else {return}
        let listButton = storageManager.getListName()
        let alertController = UIAlertController(title: "Add to list", message: nil, preferredStyle: .alert)
                
        for index in 0..<listButton.count {
            let actionTitle = listButton[index]
            let action = UIAlertAction(title: actionTitle.name, style: .default) { (action:UIAlertAction) in
                print("chose \(index + 1): \(actionTitle)")
                self.storageManager.addBookToList(book, listName: actionTitle.name)
                }
                alertController.addAction(action)
            }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive) { (action:UIAlertAction) in
            print("Cancel")
        }
        
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
}
