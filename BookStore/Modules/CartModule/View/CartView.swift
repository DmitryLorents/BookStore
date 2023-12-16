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
    
    private let imageView:UIImageView = {
        let element = UIImageView()
        element.image = UIImage(systemName: "heart.fill")
        element.tintColor = .label
        element.clipsToBounds = true
        element.contentMode = .scaleAspectFit
        return element
    }()
    
    private let imageLabel:UILabel = {
        let element = UILabel()
        element.text = "You can add your favorite books here."
        element.font = .systemFont(ofSize: 16, weight: .regular)
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
    
    func hideLabelAndImage(_ isHidden:Bool){
        imageView.isHidden = isHidden
        imageLabel.isHidden = isHidden
    }
    
    private func setupViews(){
        self.addSubview(tableView)
        tableView.addSubview(indicator)
        self.addSubview(imageView)
        self.addSubview(imageLabel)
        setupConstraints()
    }
    
    private func setupConstraints(){
        tableView.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide)
            make.bottom.equalTo(self.safeAreaLayoutGuide).inset(15)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        
        indicator.snp.makeConstraints { view in
            view.center.equalToSuperview()
        }
        
        imageView.snp.makeConstraints { make in
            make.width.height.equalTo(100)
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        imageLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(imageView.snp.bottom).offset(20)
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
