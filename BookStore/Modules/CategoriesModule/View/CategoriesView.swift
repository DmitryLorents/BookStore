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
    
    private lazy var fullSearchStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        return stack
    }()
    
    private lazy var searchTextFieldStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        return stack
    }()
    
   
    
    private lazy var grayViewForSearchTextfield: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.87, green: 0.87, blue: 0.87, alpha: 1)
        view.layer.cornerRadius = 5
        view.clipsToBounds = true
        return view
    }()
    
    private lazy var searchIconButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 24, height: 24))
        button.setImage(UIImage(systemName: "magnifyingglass", withConfiguration: UIImage.SymbolConfiguration(pointSize: 24, weight: .medium))!.withTintColor(.black, renderingMode: .alwaysOriginal), for: .normal)
        return button
    }()
    
    private lazy var searchTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = UIColor(red: 0.87, green: 0.87, blue: 0.87, alpha: 1)
        textField.placeholder = "Search title/author/ISBN no"
        return textField
    }()
    
    private lazy var grayViewForFilterButton: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.87, green: 0.87, blue: 0.87, alpha: 1)
        view.layer.cornerRadius = 5
        view.clipsToBounds = true
        return view
    }()
    
    private lazy var filterButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 24, height: 24))
        button.setImage(UIImage(named: "filterIcon"), for: .normal)
    return button
}()
    
    private lazy var categoriesHeaderLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Categories"
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        return label
    }()
    
    lazy var collectionView: UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
        cv.backgroundColor = .welcomeBackground
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(CategoryCustomCell.self, forCellWithReuseIdentifier: CategoryCustomCell.reuseID)
        return cv
    }()
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .welcomeBackground
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
        addSubview(fullSearchStack)
        fullSearchStack.addArrangedSubview(searchTextFieldStack)
        fullSearchStack.addArrangedSubview(grayViewForFilterButton)
        searchTextFieldStack.addSubview(grayViewForSearchTextfield)
        searchTextFieldStack.addSubview(searchIconButton)
        searchTextFieldStack.addSubview(searchTextField)
        grayViewForFilterButton.addSubview(filterButton)
        
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
        fullSearchStack.snp.makeConstraints{ make in
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.bottom.equalTo(categoriesHeaderLabel.snp.top).offset(-32)
            make.height.equalTo(56)
        }
        
        searchTextFieldStack.snp.makeConstraints{ make in
            make.leading.equalToSuperview()
            make.bottom.equalToSuperview()
            make.top.equalToSuperview()
            make.trailing.equalTo(grayViewForFilterButton.snp.leading).offset(-8)
//            make.width.equalTo(260)
//            make.height.equalTo(56)
        }
        
        grayViewForSearchTextfield.snp.makeConstraints{ make in
            make.bottom.leading.trailing.top.equalToSuperview()
        }
        
        grayViewForFilterButton.snp.makeConstraints{ make in
            make.trailing.equalToSuperview().offset(-20)
            make.width.equalTo(grayViewForFilterButton.snp.height).offset(-2)
        }
        
        searchIconButton.snp.makeConstraints{ make in
            make.leading.equalToSuperview().offset(8)
            make.centerY.equalToSuperview()
        }
        
        searchTextField.snp.makeConstraints{ make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(searchIconButton.snp.trailing).offset(26)
        }
        
        filterButton.snp.makeConstraints{ make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }
    
    public func transferDelegates(dataSource: UICollectionViewDataSource, delegate: UICollectionViewDelegate) {
        collectionView.dataSource = dataSource
        collectionView.delegate = delegate
    }
    
    public func setupCollectionLayout(layout: UICollectionViewFlowLayout) {
        collectionView.setCollectionViewLayout(layout, animated: true)
    }

}



