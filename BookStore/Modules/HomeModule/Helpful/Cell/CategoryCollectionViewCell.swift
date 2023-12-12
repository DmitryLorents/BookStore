//
//  CategoryCollectionViewCell.swift
//  BookStore
//
//  Created by Максим Горячкин on 05.12.2023.
//

import UIKit

class CategoryCell: UICollectionViewCell {
    static let identifier = "CategoryCollectionViewCell"
    
    lazy var categoryButton: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 14, weight: .bold)
        view.textColor = .black
        view.textAlignment = .center
        view.layer.borderColor = CGColor(red: 13/255, green: 13/255, blue: 13/255, alpha: 1)
        view.layer.borderWidth = 1
        view.frame = contentView.bounds
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
//        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = 8
        contentView.addSubview(categoryButton)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with categoty: HomeCategory) {
        categoryButton.text = categoty.rawValue
    }
}
