//
//  ListViewCell.swift
//  BookStore
//
//  Created by Admin on 16.12.2023.
//

import UIKit
import SnapKit

class ListViewCell:UITableViewCell{
    
    //MARK: - Parameters
    private let viewForCell: UIView = {
        let element = UIView()
        element.backgroundColor = UIColor(red: 0.87, green: 0.87, blue: 0.87, alpha: 1)
        element.layer.cornerRadius = 5
        return element
    }()
    
    private let nameListLabel:UILabel = {
        let element = UILabel()
        element.font = .systemFont(ofSize: 16, weight: .regular)
        element.textAlignment = .left
        element.numberOfLines = 1
        return element
    }()
    
    private let arrowImageView:UIImageView = {
        let element = UIImageView()
        element.image = UIImage(systemName: "arrow.right")
        element.tintColor = .black
        return element
    }()
    
    static let reuseID = String(describing: ListViewCell.self)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier )
        self.backgroundColor = .clear
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews(){
        self.contentView.addSubview(viewForCell)
        viewForCell.addSubview(nameListLabel)
        viewForCell.addSubview(arrowImageView)
    }
    
    private func setupConstrains(){
        viewForCell.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(8)
            make.bottom.equalToSuperview().inset(8)
            make.trailing.leading.equalToSuperview().inset(20)
        }
        
        nameListLabel.snp.makeConstraints { make in
            make.centerY.equalTo(viewForCell)
            make.leading.equalTo(viewForCell.snp.leading).offset(13)
        }
        
        arrowImageView.snp.makeConstraints { make in
            make.width.height.equalTo(16)
            make.centerY.equalTo(viewForCell)
            make.leading.equalTo(nameListLabel.snp.trailing).offset(10)
            make.trailing.equalTo(viewForCell.snp.trailing).inset(20)
        }
    }
            
}
