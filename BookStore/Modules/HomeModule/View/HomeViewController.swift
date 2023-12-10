//
//  HomeViewController.swift
//  BookStore
//
//  Created by Максим Горячкин on 05.12.2023.
//

import UIKit
import SwiftUI

protocol HomeViewProtocol: AnyObject {
    func reloadData(_ topBooks: [Book], _ recentBooks: [Book])
}

final class HomeViewController: UIViewController {
    
    // MARK: - Parameters
    var presenter: HomePresenterProtocol
    private lazy var mainCollectionView = CollectionViewFactory().createCollectionView(with: LayoutBuilder().createLayout())
    private lazy var dataSource = DataBuilder().createDataSource(for: mainCollectionView)
    
    // MARK: - Initialization
    init(presenter: HomePresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
        self.presenter.view = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(mainCollectionView)
        mainCollectionView.frame = view.bounds
        mainCollectionView.dataSource = dataSource
        registerCells()
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
    func reloadData(_ topBooks: [Book], _ recentBooks: [Book]) {
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
