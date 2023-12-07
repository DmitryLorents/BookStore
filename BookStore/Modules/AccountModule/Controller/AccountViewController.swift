//
//  5ViewController.swift
//  RainbowApp
//
//  Created by Nikolay1414 on 09.11.2023.
//

import UIKit
import SnapKit

class AccountViewController: UIViewController {
    
    //MARK: - Parameters
    private let cycleView:UIView = {
       let element = UIView()
        element.backgroundColor = .black
        element.layer.cornerRadius = 50
        element.clipsToBounds = true
        return element
    }()
    
    private let userImage:UIImageView = {
       let element = UIImageView()
        element.image = UIImage(systemName: "person.fill")
        element.tintColor = .white
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
    
    private let nameTextField:UITextField = {
       let element = UITextField()
        element.placeholder = "Enter Name"
        element.font = .systemFont(ofSize: 14)
        return element
    }()
    
    private let switcherBlack:UIButton = {
       let element = UIButton()
        element.setImage(UIImage(systemName: "sun.min.fill"), for: .normal)
        element.tintColor = .black
        element.clipsToBounds = true
        return element
    }()
    
    private let listButton:customButton = {
       let element = customButton(name: "List")
        return element
    }()
    
    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupView()
    }
    
    private func setupView(){
        view.addSubview(cycleView)
        cycleView.addSubview(userImage)
        view.addSubview(substrateView)
        substrateView.addSubview(nameLabel)
        substrateView.addSubview(nameTextField)
        view.addSubview(listButton)
        view.addSubview(switcherBlack)
        configureConstrains()
    }
    
    private func configureConstrains(){
        
        cycleView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.centerX.equalToSuperview()
            make.height.width.equalTo(100)
        }
        
        userImage.snp.makeConstraints { make in
            make.center.equalTo(cycleView)
            make.height.width.equalTo(75)
        }
        
        substrateView.snp.makeConstraints { make in
            make.top.equalTo(cycleView.snp.bottom).offset(16)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(20)
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
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        switcherBlack.snp.makeConstraints { make in
            make.width.height.equalTo(50)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(16)
            make.trailing.equalTo(view.safeAreaLayoutGuide).inset(15)
        }
        
    }
    
}
