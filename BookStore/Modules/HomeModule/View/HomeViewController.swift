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
    func reloadData(_ topBooks: [Book], _ recentBooks: [Book])
}

// MARK: - HomeViewController

final class HomeViewController: UIViewController {
    
    // MARK: - Properties
    
    var presenter: HomePresenterProtocol
    var searchIsActive = false
    private lazy var layout = LayoutBuilder().createLayout()
    private lazy var mainCollectionView = ViewFactory().createCollectionView(with: layout)
    private lazy var dataSource = DataBuilder().createDataSource(for: mainCollectionView)
    private lazy var searchController: UISearchController = {
        var controller = UISearchController(searchResultsController: SearchViewController())
        controller.showsSearchResultsController = true
        controller.delegate = self
        controller.searchBar.delegate = self
        return controller
    }()
    
    lazy var glassItem = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"),
                                         style: .done,
                                         target: self,
                                         action: #selector(toggleSearchBar))
    
    // MARK: - Initialization
    
    init(presenter: HomePresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
        self.presenter.view = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life cycle methods
    
    override func loadView() {
        super.loadView()
        view.addSubview(mainCollectionView)
        mainCollectionView.frame = view.bounds
        mainCollectionView.dataSource = dataSource
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCells()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationItem()
    }
    
    // MARK: - Private methods
    
    private func setupNavigationItem() {
        navigationItem.title = "Happy Reading!"
        navigationItem.rightBarButtonItem = glassItem
        navigationItem.searchController = searchController
    }
    
    private func registerCells() {
        mainCollectionView.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: CustomCollectionViewCell.identifier)
        mainCollectionView.register(CategoryCollectionViewCell.self, forCellWithReuseIdentifier: CategoryCollectionViewCell.identifier)
        mainCollectionView.register(SectionHeader.self, 
                                    forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                    withReuseIdentifier: SectionHeader.identifier)
    }
    
    // MARK: - Objective-C private methods
    
    @objc private func toggleSearchBar() {
        navigationItem.searchController = searchController
        navigationController?.view.layoutIfNeeded()
        searchController.searchBar.becomeFirstResponder()
    }
}

// MARK: - UICollectionViewDelegate methods

extension HomeViewController: UICollectionViewDelegate {
    
}

// MARK: - HomeViewProtocol methods

extension HomeViewController: HomeViewProtocol {
    func reloadData(_ topBooks: [Book], _ recentBooks: [Book]) {
        DataBuilder().updateDataSource(dataSource, topBooks: topBooks, recentBooks: recentBooks)
    }
}

// MARK: - UISearchController and UISearchBarDelegate methods

extension HomeViewController: UISearchControllerDelegate, UISearchBarDelegate {
    func willDismissSearchController(_ searchController: UISearchController) {
        navigationItem.searchController = nil
        navigationController?.view.layoutIfNeeded()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchController.searchBar.text = ""
        searchController.searchBar.resignFirstResponder()
        searchController.dismiss(animated: true, completion: nil)
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
