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
    lazy var tableView: UITableView = {
        let element = UITableView()
        element.register(ListViewCell.self, forCellReuseIdentifier: ListViewCell.reuseID)
        element.separatorStyle = .none
        element.estimatedRowHeight = 82
        element.showsVerticalScrollIndicator = false
        element.backgroundColor = .clear
        return element
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Methods
    private func setupViews(){
        self.addSubview(tableView)
        self.backgroundColor = .systemBackground
        setupConstrains()
    }
    
    private func setupConstrains(){
        tableView.snp.makeConstraints { make in
            make.top.bottom.equalTo(self.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview()
        }
    }
}

extension ListsView {
    func transferDelegates(dataSource: UITableViewDataSource, delegate: UITableViewDelegate){
        tableView.delegate = delegate
        tableView.dataSource = dataSource
    }
}
