//
//  CustonCollectionViewCell.swift
//  BookStore
//
//  Created by Максим Горячкин on 04.12.2023.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewCell {
    static let identifier = "CustomCollectionViewCell"
    
    lazy var mainView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.layer.cornerRadius = 8
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var imageView: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = .cyan
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var subView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var categoryTitle: UILabel = {
        let view = UILabel()
        view.numberOfLines = 0
        view.font = .systemFont(ofSize: 11)
        view.textColor = .white
        view.textAlignment = .left
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var mainTitle: UILabel = {
        let view = UILabel()
        view.numberOfLines = 2
        view.font = .systemFont(ofSize: 16, weight: .bold)
        view.textColor = .white
        view.textAlignment = .left
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var authorTitle: UILabel = {
        let view = UILabel()
        view.numberOfLines = 0
        view.font = .systemFont(ofSize: 11, weight: .heavy)
        view.textColor = .white
        view.textAlignment = .left
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.backgroundColor = .gray
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = 8
        contentView.addSomeSubviews(views: imageView, subView)
        subView.addSomeSubviews(views: categoryTitle, mainTitle, authorTitle)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 11),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -43),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -80),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 43),
            
            subView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            subView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            subView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            subView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.4)
        ])
        
        NSLayoutConstraint.activate([
            categoryTitle.topAnchor.constraint(equalTo: subView.topAnchor, constant: 12),
            categoryTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            categoryTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            
            mainTitle.topAnchor.constraint(equalTo: categoryTitle.bottomAnchor),
            mainTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            mainTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            
            authorTitle.bottomAnchor.constraint(equalTo: subView.bottomAnchor, constant: -12),
            authorTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            authorTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with book: Book) {
        categoryTitle.text = book.category
        mainTitle.text = book.name
        authorTitle.text = book.author
    }
}
