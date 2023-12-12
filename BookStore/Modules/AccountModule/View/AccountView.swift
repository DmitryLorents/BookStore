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
    let userImage:UIImageView = {
       let element = UIImageView()
        element.image = UIImage(named: "avatarAccount")
        element.layer.cornerRadius = 50
        element.layer.masksToBounds = true
        element.isUserInteractionEnabled = true
        element.contentMode = .scaleAspectFill
        return element
    }()
    
    private let substrateView:UIView = {
       let element = UIView()
        element.backgroundColor = UIColor(red: 0.87, green: 0.87, blue: 0.87, alpha: 1)
        element.layer.cornerRadius = 5
        return element
    }()
    
    private let nameLabel:UILabel = {
       let element = UILabel()
        element.text = "Name:"
        element.font = .systemFont(ofSize: 14, weight: .regular)
        return element
    }()
    
    lazy var nameTextField:UITextField = {
       let element = UITextField()
        element.placeholder = "Enter Name"
        element.font = .systemFont(ofSize: 16, weight: .bold)
        element.returnKeyType = .done
        return element
    }()
    
    let switcherBlack:UIImageView = {
       let element = UIImageView()
        element.image = UIImage(systemName: "sun.min.fill")
        element.tintColor = .black
        element.contentMode = .scaleAspectFit
        element.clipsToBounds = true
        element.isUserInteractionEnabled = true
        return element
    }()
    
    let listButton:customButton = {
       let element = customButton(name: "List")
        return element
    }()
    
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .systemBackground
         setupViews()
     }
     
     required init?(coder: NSCoder) {
         fatalError("init(coder:) has not been implemented")
     }
   
    
    //MARK: - Methods
    private func setupViews(){
        self.addSubview(userImage)
        self.addSubview(substrateView)
        self.addSubview(listButton)
        self.addSubview(switcherBlack)
        substrateView.addSubview(nameLabel)
        substrateView.addSubview(nameTextField)
        setupConstrains()
    }
    
    private func setupConstrains(){
        
        userImage.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(20)
            make.centerX.equalToSuperview()
            make.height.width.equalTo(100)
        }
        
        substrateView.snp.makeConstraints { make in
            make.top.equalTo(userImage.snp.bottom).offset(16)
            make.leading.trailing.equalTo(self.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(56)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.centerY.equalTo(substrateView)
            make.leading.equalTo(substrateView.snp.leading).offset(20)
        }
        
        nameTextField.snp.makeConstraints { make in
            make.centerY.equalTo(substrateView)
            make.trailing.equalTo(substrateView.snp.trailing).inset(10)
            make.leading.equalTo(nameLabel.snp.trailing).offset(57)
        }
        
        listButton.snp.makeConstraints { make in
            make.top.equalTo(substrateView.snp.bottom).offset(20)
            make.leading.trailing.equalTo(self.safeAreaLayoutGuide).inset(20)
        }
        
        switcherBlack.snp.makeConstraints { make in
            make.width.height.equalTo(35)
            make.bottom.equalTo(self.safeAreaLayoutGuide).inset(30)
            make.trailing.equalTo(self.safeAreaLayoutGuide).inset(10)
        }
        
    }
}

//MARK: - Transfer Extension
extension AccountView{
    func transferDelegates(delegateTextField: UITextFieldDelegate) {
        nameTextField.delegate = delegateTextField
    }
}
