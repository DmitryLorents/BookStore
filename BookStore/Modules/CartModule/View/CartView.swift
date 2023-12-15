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
    
    private let indicator = UIActivityIndicatorView(style: .large)
    
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
    func reloadTableView() {
        tableView.reloadData()
    }
    
    private func setupViews(){
        self.addSubview(tableView)
        tableView.addSubview(indicator)
        setupConstraints()
    }
    
    private func setupConstraints(){
        tableView.snp.makeConstraints { make in
            make.top.bottom.equalTo(self.safeAreaLayoutGuide)
            make.leading.equalToSuperview().inset(20)
            make.trailing.equalToSuperview().inset(20)
        }
        indicator.snp.makeConstraints { view in
            view.center.equalToSuperview()
        }
    }
}
//MARK: - Extensions
extension CartView{
    func transferDelegates(dataSource: UITableViewDataSource, delegate: UITableViewDelegate){
        tableView.delegate = delegate
        tableView.dataSource = dataSource
    }
    
    func startAnimating() {
        indicator.startAnimating()
        print("start animate")
    }
    
    func stopAnimating() {
        indicator.stopAnimating()
        print("stop animate")
    }
}
