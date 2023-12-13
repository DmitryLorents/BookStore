//
//  BookCell.swift
//  BookStore
//
//  Created by Максим Горячкин on 04.12.2023.
//

import UIKit
import Kingfisher

class BookCell: UICollectionViewCell {
    static let identifier = String(describing: BookCell.self)
    
    private lazy var mainView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.layer.cornerRadius = 8
        view.clipsToBounds = true
        return view
    }()
    
    private lazy var imageView: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = .gray
        return view
    }()
    
    private lazy var subView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }()
    
    private let categoryTitle: UILabel = .common(
        .systemFont(ofSize: 11),
        numberOfLines: 1
    )
    
    private let mainTitle: UILabel = .common(
        .systemFont(ofSize: 16, weight: .bold),
        numberOfLines: 2
    )
    
    private let authorTitle: UILabel = .common(
        .systemFont(ofSize: 11, weight: .heavy),
        numberOfLines: 1
    )
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.backgroundColor = .gray
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = 8
        contentView.addSomeSubviews(views: imageView, subView)
        contentView.disableChildrenTAMIC()
        subView.addSomeSubviews(views: categoryTitle, mainTitle, authorTitle)
        subView.disableChildrenTAMIC()
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 11),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -43),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -80),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 43),
            
            subView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            subView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            subView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            subView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.4),
        
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
        imageView.kf.setImage(with: OpenLibraryEndpoints.image(book.imageID))
    }

}
