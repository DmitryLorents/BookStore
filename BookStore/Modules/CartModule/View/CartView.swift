//
//  settingsView.swift
//

import UIKit

class CartView: UIView {

    // MARK: - Parameters
    private lazy var tableView:UITableView={
        let element = UITableView()
        element.register(CartViewCell.self, forCellReuseIdentifier: CartViewCell.reuseID)
        element.separatorStyle = .none
        element.estimatedRowHeight = 148
        element.showsVerticalScrollIndicator = false
        element.backgroundColor = .clear
        return element
    }()
    //MARK: - Init
   override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Methods
    private func setupViews(){
        self.addSubview(tableView)
        setupConstraints()
    }
    
    private func setupConstraints(){
        tableView.snp.makeConstraints { make in
            make.top.bottom.equalTo(self.safeAreaLayoutGuide)
            make.leading.equalToSuperview().inset(20)
            make.trailing.equalToSuperview().inset(20)
        }
    }
}
//MARK: - Extensions
extension CartView{
    func transferDelegates(dataSource: UITableViewDataSource, delegate: UITableViewDelegate){
        tableView.delegate = delegate
        tableView.dataSource = dataSource
    }
}
