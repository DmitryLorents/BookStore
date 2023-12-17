//
//  HomeViewController.swift
//  BookStore
//
//  Created by Максим Горячкин on 05.12.2023.
//

import UIKit
import SwiftUI

// MARK: - HomeViewProtocol

protocol HomeViewProtocol: AnyObject {
    func render(_ viewModel: HomeViewModel)
    func render(_ topBooks: [Book], _ recentBooks: [Book], _ categories: [CategoryViewModel])
    func showError(_ message: String)
    func renderNavigationItem()
    func presentCartVC(_ books: [Book], title: String?)
    func presentProductVC(_ book: Book)
    func stopAnimateIndicator()
    func startAnimateIndicator()
}

// MARK: - HomeViewController

final class HomeViewController: UIViewController {
    
    // MARK: - Properties
    
    let presenter: HomePresenterProtocol
    private let searchController: UISearchController
    private let indicator = UIActivityIndicatorView(style: .large)
    private let mainCollectionView: UICollectionView = .createCollectionView(with: .bookLayout())
    private lazy var dataSource = BookSectionDataSource(mainCollectionView)
    private lazy var collectionDelegate = BooksCollectionDelegate(mainCollectionView)
    private lazy var searchDelegeate = HomeSearchControllerDelegate(searchController: searchController, presenter: presenter)
    private lazy var glassItem = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"),
                                                 style: .done,
                                                 target: self,
                                                 action: #selector(toggleSearchBar))
    
    // MARK: - Initialization
    
    init(
        presenter: HomePresenterProtocol,
        searchController: UISearchController
    ) {
        self.presenter = presenter
        self.searchController = searchController
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life cycle methods
    
    override func loadView() {
        super.loadView()
        checkOnboarding()
        view.addSubview(mainCollectionView)
        view.addSubview(indicator)
        mainCollectionView.frame = view.bounds
        indicator.frame = view.bounds
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
        indicator.startAnimating()
        colectionDelegateSetup()
        searchDelegateSetup()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationItem()
        presenter.viewWillAppear()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        presenter.viewDidDisappear()
    }
    
    // MARK: - Private methods
    private func setupNavigationItem() {
        navigationItem.title = "Happy Reading!"
        navigationItem.rightBarButtonItem = glassItem
    }
    
    private func colectionDelegateSetup() {
        collectionDelegate.didSelectCategoryAt = presenter.didSelectCategory(at:)
        collectionDelegate.didSelectTopAt = presenter.didSelectTopBook(at:)
        collectionDelegate.didSelectRecentAt = presenter.didSelectRecentBook(at:)
    }
    
    private func searchDelegateSetup() {
        searchDelegeate.check()
    }
    
    private func checkOnboarding() {
        let onboardingShown = UserDefaults.standard.bool(forKey: "OnboardingShown")
        
        if !onboardingShown {
            UserDefaults.standard.setValue(true, forKey: "OnboardingShown")
            let vc = WelcomeViewController()
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: false)
        }
    }
    
    // MARK: - Objective-C private methods
    
    @objc private func toggleSearchBar() {
        navigationItem.searchController = searchController
        navigationController?.view.layoutIfNeeded()
        tabBarController?.tabBar.isHidden = true
        presenter.willAppearSearchController()
        searchController.searchBar.becomeFirstResponder()
    }
}

// MARK: - HomeViewProtocol methods

extension HomeViewController: HomeViewProtocol {
    func render(_ viewModel: HomeViewModel) {
        dataSource.updateHeader(with: viewModel)
        dataSource.update(categoryModels: viewModel.categories, topBooks: viewModel.topBooks, recentBooks: viewModel.recentBooks)
    }
    
    func startAnimateIndicator() {
        indicator.startAnimating()
    }
    
    func stopAnimateIndicator() {
        indicator.stopAnimating()
    }
    
    func render(_ topBooks: [Book], _ recentBooks: [Book], _ categories: [CategoryViewModel]) {
        dataSource.update(categoryModels: categories, topBooks: topBooks, recentBooks: recentBooks)
    }
    
    func showError(_ message: String) {
        
    }
    
    func presentCartVC(_ books: [Book], title: String?) {
        navigationController?.pushViewController(CartViewController(books: books, titleCart: title), animated: true)
    }
    
    func presentProductVC(_ book: Book) {
        navigationController?.pushViewController(ProductViewController(book: book), animated: true)
    }
    

    func renderNavigationItem() {
        navigationItem.searchController = nil
        tabBarController?.tabBar.isHidden = false
    }
}
