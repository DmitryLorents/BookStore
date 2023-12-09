//
//  HomeViewController.swift
//  BookStore
//
//  Created by Максим Горячкин on 05.12.2023.
//

import UIKit
import SwiftUI

protocol HomeViewProtocol: AnyObject {
    func updateTopBooks(_ books: [Book])
    func updateRecentBooks(_ books: [Book])
    func reloadData()
}

final class HomeViewController: UIViewController {
    
    // MARK: - Parameters
    var topBooks = [Book]()
    var recentBooks = [Book]()
    private lazy var mainCollectionView = CollectionViewFactory().createCollectionView(with: LayoutBuilder().createLayout())
    private lazy var dataSource = DataBuilder().createDataSource(for: mainCollectionView, from: topBooks, and: recentBooks)
    var presenter: HomePresenterProtocol
    
    // MARK: - Initialization
    init(presenter: HomePresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
        self.view = view
        self.view.addSubview(mainCollectionView)
        self.presenter.view = self
        mainCollectionView.frame = self.view.bounds
        mainCollectionView.dataSource = dataSource
        registerCells()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func registerCells() {
        mainCollectionView.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: CustomCollectionViewCell.identifier)
        mainCollectionView.register(CategoryCollectionViewCell.self, forCellWithReuseIdentifier: CategoryCollectionViewCell.identifier)
        mainCollectionView.register(SectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SectionHeader.identifier)
    }
}

extension HomeViewController: UICollectionViewDelegate {
    
}

extension HomeViewController: HomeViewProtocol {
    func updateTopBooks(_ books: [Book]) {
        topBooks = books
        reloadData()
    }
    
    func updateRecentBooks(_ books: [Book]) {
        recentBooks = books
        reloadData()
    }
    
    func reloadData() {
        DataBuilder().updateDataSource(dataSource, topBooks: topBooks, recentBooks: recentBooks)
    }
}

struct ListProvider: PreviewProvider {
    static var previews: some View {
        ConteinerView().ignoresSafeArea()
    }
    
    struct ConteinerView: UIViewControllerRepresentable {
        let homeVC = HomeViewController(presenter: HomePresenter())
        
        func makeUIViewController(context: Context) -> some UIViewController {
            homeVC
        }
        
        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
            
        }
    }
}
