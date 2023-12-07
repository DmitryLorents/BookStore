//
//  5View.swift
//  RainbowApp
//
//  Created by Dmitry on 09.11.2023.
//

import UIKit
import SnapKit

class AccountView: UIView {
    
    //MARK: - Parameters
    
    
    
    //MARK: - Init
    
   
    
    //MARK: - Methods
    
   
}

class customButton: UIButton {
    
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
    
    init(name: String) {
        super.init(frame: .zero)
        nameButtonLabel.text = name
        setupViews()
        setupButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
