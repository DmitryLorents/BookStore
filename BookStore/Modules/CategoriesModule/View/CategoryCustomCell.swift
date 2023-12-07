//
//  CategoryCustomCell.swift
//  BookStore
//
//  Created by Igor Guryan on 05.12.2023.
//

import UIKit

class CategoryCustomCell: UICollectionViewCell {
    //MARK: - Parameters
    
    
    var data: CustomData? {
       didSet {
           guard let data = data else { return }
           backgroundImageView.image = UIImage(named: data.backgroundImage)
           categorieNameLabel.text = data.title
           
       }
   }
    private lazy var gradient: CAGradientLayer = {
        let gradient = CAGradientLayer()
        gradient.colors = [
        UIColor(red: 0, green: 0, blue: 0, alpha: 1).cgColor,
        UIColor(red: 0, green: 0, blue: 0, alpha: 0.3).cgColor
        ]
        gradient.frame = CGRect(x: 0, y: 0, width: 165, height: 100)
        return gradient
    }()
    
    private lazy var backgroundImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.addSublayer(gradient)
        imageView.layer.cornerRadius = 5
        imageView.clipsToBounds = true
        return imageView
    }()

    private lazy var categorieNameLabel: UILabel = {
        var label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .white
        return label
    }()
    
    static let reuseID = String(describing: CategoryCustomCell.self)
    
    //MARK: - Init 
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupView()
        setupLayout() 
        contentView.layer.cornerRadius = 5

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Private Methods
    private func setupView() {
        contentView.addSubview(backgroundImageView)
        contentView.addSubview(categorieNameLabel)
    }
    
    private func setupLayout() {
        backgroundImageView.snp.makeConstraints{ make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        categorieNameLabel.snp.makeConstraints{ make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }
}
