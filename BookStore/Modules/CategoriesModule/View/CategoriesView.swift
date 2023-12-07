//
//  File.swift
//  RainbowApp
//
//  Created by Nikita Savchik on 15/11/2023.
//

import UIKit
import SnapKit

class CategoriesView: UIView {
    
    //MARK: - Parameters
    
    private let data = CategoriesModel.data
    
    private lazy var categoriesHeaderLabel: UILabel = {
        var label = UILabel()
        label.text = "Categories"
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        return label
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 165, height: 100)
        layout.minimumLineSpacing = 20
        layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 10, right: 20)
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(CategoryCustomCell.self, forCellWithReuseIdentifier: CategoryCustomCell.reuseID)
        return cv
    }()
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Methods
    private func setupView() {
        addSubview(collectionView)
        addSubview(categoriesHeaderLabel)
    }
    
    private func setupLayout() {
        collectionView.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(232)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview().offset(-96)
        }
        
        categoriesHeaderLabel.snp.makeConstraints{ make in
            make.bottom.equalTo(collectionView.snp.top).offset(-30)
            make.leading.equalToSuperview().offset(20)
        }
    }
    
    public func transferDelegates(dataSource: UICollectionViewDataSource, delegate: UICollectionViewDelegate) {
        collectionView.dataSource = dataSource
        collectionView.delegate = delegate
    }

}



