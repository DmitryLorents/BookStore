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
    func showError(_ message: String)
    func presentCartVC(_ books: [Book])
}

// MARK: - HomeViewController

final class HomeViewController: UIViewController {
    private let searchController: UISearchController
    private let indicator = UIActivityIndicatorView(style: .large)
    private let mainCollectionView: UICollectionView = .createCollectionView(with: .bookLayout())
    private lazy var dataSource = BookSectionDataSource(mainCollectionView)
    private lazy var collectionDelegate = BooksCollectionDelegate(mainCollectionView)
    private lazy var searchDelegeate = HomeSearchControllerDelegate(searchController: searchController, navigationController: self.navigationController)
    
    // MARK: - Properties
    let presenter: HomePresenterProtocol
    let glassItem = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"),
                                                     style: .done,
                                                     target: HomeViewController.self,
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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationItem()
        presenter.viewDidAppear()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        presenter.viewDidDisappear()
    }
    
    // MARK: - Private methods
    private func setupNavigationItem() {
        navigationItem.title = "Happy Reading!"
        navigationItem.rightBarButtonItem = glassItem
        navigationItem.searchController = searchController
    }
    
    private func colectionDelegateSetup() {
        collectionDelegate.didSelectCategoryAt = presenter.didSelectCategory(at:)
        collectionDelegate.didSelectTopAt = presenter.didSelectTopBook(at:)
        collectionDelegate.didSelectRecentAt = presenter.didSelectRecentBook(at:)
    }
    
    // MARK: - Objective-C private methods
    
    @objc private func toggleSearchBar() {
        searchDelegeate.check()
//        navigationItem.searchController = searchController
//        navigationController?.view.layoutIfNeeded()
//        searchController.searchBar.becomeFirstResponder()
    }
}

// MARK: - HomeViewProtocol methods

extension HomeViewController: HomeViewProtocol {
    func render(_ viewModel: HomeViewModel) {
        indicator.stopAnimating()
        dataSource.updateHeader(with: viewModel)
        dataSource.update(topBooks: viewModel.topBooks, recentBooks: viewModel.recentBooks)
    }
    
    func showError(_ message: String) {
        
    }
    
    func presentCartVC(_ books: [Book]) {
        
    }
}



//
//struct ListProvider: PreviewProvider {
//    static var previews: some View {
//        ConteinerView().ignoresSafeArea()
//    }
//
//    struct ConteinerView: UIViewControllerRepresentable {
//        let homeVC = HomeViewController(presenter: HomePresenter())
//
//        func makeUIViewController(context: Context) -> some UIViewController {
//            homeVC
//        }
//
//        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
//
//        }
//    }
//}
