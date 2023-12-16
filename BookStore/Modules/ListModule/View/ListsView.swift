//
//  ListsView.swift
//  BookStore
//
//  Created by Admin on 16.12.2023.
//

import UIKit
import SnapKit

class ListsView: UIView {
    
    //MARK - Parameters
    private lazy var tableView: UITableView = {
        let element = UITableView()
        element.separatorStyle = .none
        element.showsVerticalScrollIndicator = false
        element.backgroundColor = .clear
        return element
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Methods
    private func setupViews(){
        self.addSubview(tableView)
    }
    
    private func setupConstrains(){
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(self.safeAreaLayoutGuide)
        }
    }
}
