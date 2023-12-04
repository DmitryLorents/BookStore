//
//  CellFactory.swift
//  BookStore
//
//  Created by Максим Горячкин on 04.12.2023.
//

import UIKit

protocol CellViewFactoryProtocol {
    func createCellView(category: String, name: String, author: String) -> UIView
}

class CellViewFactory: CellViewFactoryProtocol {
    func createCellView(category: String, name: String, author: String) -> UIView {
        lazy var mainView: UIView = {
            let view = UIView()
            view.backgroundColor = .gray
            view.layer.cornerRadius = 8
            view.clipsToBounds = true
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
        }()
        
        lazy var imageView: UIImageView = {
            let view = UIImageView()
            view.backgroundColor = .red
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
        }()
        
        lazy var subView: UIView = {
            let view = UIView()
            view.backgroundColor = .green
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
        }()
        
        lazy var categoryTitle: UILabel = {
            let view = UILabel()
            view.text = category
            view.numberOfLines = 0
            view.font = .systemFont(ofSize: 11)
            view.textAlignment = .left
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
        }()
        
        lazy var mainTitle: UILabel = {
            let view = UILabel()
            view.text = name
            view.numberOfLines = 0
            view.font = .systemFont(ofSize: 16, weight: .bold)
            view.textAlignment = .left
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
        }()
        
        lazy var authorTitle: UILabel = {
            let view = UILabel()
            view.text = author
            view.numberOfLines = 0
            view.font = .systemFont(ofSize: 11, weight: .heavy)
            view.textColor = .systemGray
            view.textAlignment = .left
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
        }()
        
        mainView.addSomeSubviews(views: imageView, subView)
        subView.addSomeSubviews(views: categoryTitle, mainTitle, authorTitle)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 11),
            imageView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -43),
            imageView.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: -80),
            imageView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 43),
            
            subView.bottomAnchor.constraint(equalTo: mainView.bottomAnchor),
            subView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor),
            subView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor),
            subView.heightAnchor.constraint(equalTo: mainView.heightAnchor, multiplier: 0.4)
        ])
        
        NSLayoutConstraint.activate([
            categoryTitle.topAnchor.constraint(equalTo: subView.topAnchor, constant: 12),
            categoryTitle.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -12),
            categoryTitle.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 12),
            
            mainTitle.topAnchor.constraint(equalTo: categoryTitle.bottomAnchor),
            mainTitle.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -12),
            mainTitle.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 12),
            
            authorTitle.bottomAnchor.constraint(equalTo: subView.bottomAnchor, constant: -12),
            authorTitle.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -12),
            authorTitle.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 12)
        ])
        
        return mainView
    }
}
