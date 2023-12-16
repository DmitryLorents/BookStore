//
//  CartViewCell.swift
//  BookStore
//
//  Created by Admin on 05.12.2023.
//

import UIKit
import SnapKit
import Kingfisher

class CartViewCell: UITableViewCell {
    
    //MARK: - Parameters
    private let viewForCell:UIView = {
       let element = UIView()
        element.backgroundColor = .black
        element.layer.cornerRadius = 8
        element.clipsToBounds = true
        return element
    }()
    
    private let genreBookLabel:UILabel = {
       let element = UILabel()
        element.textColor = UIColor(red: 0.87, green: 0.87, blue: 0.87, alpha: 1)
        element.font = UIFont.systemFont(ofSize: 10, weight: .regular)
        element.numberOfLines = 0
        return element
    }()
    
    private let nameBookLabel:UILabel = {
        let element = UILabel()
        element.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        element.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        element.numberOfLines = 0
        return element
    }()
    
    private let authorBookLabel:UILabel = {
       let element = UILabel()
        element.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        element.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        element.numberOfLines = 1
        return element
    }()
    
    private let imageBookImageView:UIImageView = {
        let element = UIImageView()
        element.contentMode = .scaleAspectFill
        element.backgroundColor = .systemBackground
        element.clipsToBounds = true
        return element
    }()
    
    let crossButton:UIButton = {
        let element = UIButton()
        element.setImage(UIImage(systemName:"xmark"), for: .normal)
        element.tintColor = .white
        return element
    }()
    
    static let reuseID = String(describing: CartViewCell.self)
    
    //MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier )
        self.backgroundColor = .clear
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - private func
    private func setupViews(){
        self.contentView.addSubview(viewForCell)
        viewForCell.addSubview(genreBookLabel)
        viewForCell.addSubview(nameBookLabel)
        viewForCell.addSubview(authorBookLabel)
        viewForCell.addSubview(imageBookImageView)
        viewForCell.addSubview(crossButton)
        setupConstraints()
        
    }
    
    private func setupConstraints(){
        viewForCell.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(8)
            make.bottom.equalToSuperview().inset(8)
            make.trailing.leading.equalToSuperview().inset(20)
            make.height.equalTo(140)
        }
        
        imageBookImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalTo(viewForCell.snp.bottom)
            make.width.equalTo(90)
        }
        
        genreBookLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(14)
            make.leading.equalTo(imageBookImageView.snp.trailing).offset(10)
            make.trailing.equalToSuperview().inset(54)
        }
        
        nameBookLabel.snp.makeConstraints { make in
            make.top.equalTo(genreBookLabel.snp.bottom).offset(5)
            make.leading.equalTo(imageBookImageView.snp.trailing).offset(10)
            make.trailing.equalToSuperview().inset(54)
        }
        
        authorBookLabel.snp.makeConstraints { make in
            make.top.equalTo(nameBookLabel.snp.bottom).offset(5)
            make.leading.equalTo(imageBookImageView.snp.trailing).offset(10)
            make.trailing.equalToSuperview().inset(54)
        }
        
        crossButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(18)
            make.trailing.equalToSuperview().inset(13)
            make.width.height.equalTo(20)
        }
    }
    
    func configureCell(with book: Book){
        imageBookImageView.kf.indicatorType = .activity
        imageBookImageView.kf.setImage(with: OpenLibraryEndpoints.image(book.imageID))
        nameBookLabel.text = book.name
        authorBookLabel.text = book.author
        genreBookLabel.text = book.category
    }
}

