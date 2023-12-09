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
    
    lazy var button: UIButton = {
        let view = UIButton()
        view.titleLabel?.font = .systemFont(ofSize: 14)
        view.setTitle("see more", for: .normal)
        view.setTitleColor(.black, for: .normal)
        view.titleLabel?.textAlignment = .right
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(maintitle)
        addSubview(button)
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
            
            button.trailingAnchor.constraint(equalTo: trailingAnchor),
            button.bottomAnchor.constraint(equalTo: bottomAnchor),
            button.topAnchor.constraint(equalTo: topAnchor),
            button.leadingAnchor.constraint(equalTo: maintitle.trailingAnchor)
        ])
        
    }
    
    func configure(with title: String) {
        self.maintitle.text = title
    }
    
    @objc func buttonTapped() {
        print("Button was tapped")
    }
    
}
