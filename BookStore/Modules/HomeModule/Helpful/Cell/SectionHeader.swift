//
//  SectionHeader.swift
//  BookStore
//
//  Created by Максим Горячкин on 05.12.2023.
//

import UIKit

class SectionHeader: UICollectionReusableView {
    
    static let identifier = "CustomCollectionViewCell"
    
    lazy var maintitle: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 20, weight: .bold)
        view.textAlignment = .left
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var subtitle: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 14)
        view.textAlignment = .right
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(maintitle)
        addSubview(subtitle)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            maintitle.topAnchor.constraint(equalTo: topAnchor),
            maintitle.leadingAnchor.constraint(equalTo: leadingAnchor),
            maintitle.bottomAnchor.constraint(equalTo: bottomAnchor),
            maintitle.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5),
            
            subtitle.trailingAnchor.constraint(equalTo: trailingAnchor),
            subtitle.bottomAnchor.constraint(equalTo: bottomAnchor),
            subtitle.topAnchor.constraint(equalTo: topAnchor),
            subtitle.leadingAnchor.constraint(equalTo: maintitle.trailingAnchor)
        ])
        
    }
    
    func configure(with title: String, subtitle: String) {
        self.maintitle.text = title
        self.subtitle.text = subtitle
    }
    
}
