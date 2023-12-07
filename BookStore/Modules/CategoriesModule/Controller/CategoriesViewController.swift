//
//  ResultsViewController.swift
//  RainbowApp
//
//  Created by Nikita Savchik on 15/11/2023.
//

import UIKit

class CategoriesViewController: UIViewController {
    
    
    //MARK: - Private Parameters
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
        cv.register(CategoryCustomCell.self, forCellWithReuseIdentifier: "cell")
        cv.delegate = self
        cv.dataSource = self
//        cv.backgroundColor = .cyan
        return cv
    }()
    
    //MARK: - Life cycle
    
    override func viewDidLoad() {
        setupView()
        setupLayout()
        
//        view.backgroundColor = .yellow
        
    }
    
    //MARK: - Private Methods
    private func setupView() {
        view.addSubview(collectionView)
        view.addSubview(categoriesHeaderLabel)
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

}

//MARK: - Extencion for ViewCollection Protocols

extension CategoriesViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CategoryCustomCell
            cell.data = self.data[indexPath.item]
            return cell
        }
}




    #Preview { CategoriesViewController() }
