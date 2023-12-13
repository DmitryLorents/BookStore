//
//  CategoryCell.swift
//  BookStore
//
//  Created by Максим Горячкин on 05.12.2023.
//

import UIKit

class CategoryCell: UICollectionViewCell {
    static let identifier = String(describing: CategoryCell.self)
    private var isChange = true
    
    lazy var categoryButton: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 14, weight: .bold)
        view.textColor = .black
        view.textAlignment = .center
        view.layer.borderColor = CGColor(red: 13/255, green: 13/255, blue: 13/255, alpha: 1)
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 6
        view.frame = contentView.bounds
        view.clipsToBounds = true
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(categoryButton)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with categoty: HomeCategory) {
        categoryButton.text = categoty.rawValue
    }
    
    func resetCell() {
        categoryButton.backgroundColor = .white
        categoryButton.textColor = .black
        isChange = true
    }
    
    func checkCell() {
        isChange.toggle()
        if isChange {
            categoryButton.backgroundColor = .white
            categoryButton.textColor = .black
        } else {
            categoryButton.backgroundColor = .black
            categoryButton.textColor = .white
        }
        
        
    }
}
