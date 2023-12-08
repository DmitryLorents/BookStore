//
//  CustomButton.swift
//  BookStore
//
//  Created by Dmitry on 08.12.2023.
//

import UIKit

class customButton: UIButton {
    
    //MARK: - Parameters
    private let nameButtonLabel:UILabel = {
       let element = UILabel()
        element.font = .systemFont(ofSize: 14, weight: .regular)
        element.textColor = .black
        return element
    }()
    
    private let imageButton:UIImageView = {
        let element = UIImageView()
        element.image = UIImage(systemName: "arrow.right")
        element.tintColor = .black
        return element
    }()
    
    //MARK: - Init
    init(name: String) {
        super.init(frame: .zero)
        nameButtonLabel.text = name
        setupViews()
        setupButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Methods
    private func setupViews(){
        addSubview(nameButtonLabel)
        addSubview(imageButton)
        setupConstraints()
    }
    
    private func setupButton() {
        self.layer.cornerRadius = 5
        self.backgroundColor = UIColor(red: 0.87, green: 0.87, blue: 0.87, alpha: 1)
        imageButton.contentMode = .scaleAspectFit
    }
    
    private func setupConstraints(){
        
        self.snp.makeConstraints { make in
            make.height.equalTo(56)
        }
        
        nameButtonLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(20)
        }
        
        imageButton.snp.makeConstraints { make in
            make.height.width.equalTo(20)
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(20)
        }
        
    }
}
