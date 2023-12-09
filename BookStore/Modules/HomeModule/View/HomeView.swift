//
//  HomeView.swift
//  BookStore
//
//  Created by Максим Горячкин on 05.12.2023.
//

import UIKit


final class HomeView: UIView {
    
    //MARK: - Properties
    var topBooks = [Book(name: "123", author: "123", category: "123")]
    var recentBook = [Book(name: "123", author: "123", category: "123")]
    private lazy var mainCollectionView = CollectionViewFactory().createCollectionView(with: LayoutBuilder().createLayout())
    private lazy var dataSource = DataBuilder().createDataSource(for: mainCollectionView, from: topBooks, and: recentBook)
    
    //MARK: - Initialization
    
    init() {
        super.init(frame: .zero)
        addSubview(mainCollectionView)
        mainCollectionView.dataSource = dataSource
        setupConstraints()
        registerCells()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Methods
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            mainCollectionView.topAnchor.constraint(equalTo: topAnchor),
            mainCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            mainCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            mainCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor)
        ])
    }
    
    func registerCells() {
        mainCollectionView.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: CustomCollectionViewCell.identifier)
        mainCollectionView.register(CategoryCollectionViewCell.self, forCellWithReuseIdentifier: CategoryCollectionViewCell.identifier)
//        mainCollectionView.register(SectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SectionHeader.identifier)
    }
    
}
