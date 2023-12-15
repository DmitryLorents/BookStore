//
//  CartViewController.swift
//

import UIKit
import SnapKit

class CartViewController: UIViewController {
    
    // MARK: - Parameters
    
    private let cartView = CartView()
    private var books: [Book]? {
        didSet {
            cartView.reloadTableView()
        }
    }
    private let storageManager = StorageManagerRealm.shared
    private let titleCart:String?
    
    // MARK: - Init
    init (books: [Book]?, titleCart: String?) {
        self.books = books
        self.titleCart = titleCart
        super.init(nibName: nil, bundle: nil)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setViews()
        setupNavigationBar()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //Favorites case
        if title == nil { books = storageManager.getBooks() }
    }
    
    //MARK: - PrivateMethods
    fileprivate func setViews() {
        view.backgroundColor = .systemBackground
        cartView.transferDelegates(dataSource: self, delegate: self)
        view = cartView
        title = titleCart
    }
    
    private func setupNavigationBar(){
        let navBar = navigationController?.navigationBar
        navBar?.tintColor = .black
        navBar?.backIndicatorImage = UIImage(systemName: "arrow.left")
        navBar?.backIndicatorTransitionMaskImage = UIImage(systemName: "arrow.left")
        navBar?.topItem?.backButtonTitle = ""
    }
}

//MARK: - Extensions
extension CartViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        books?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let books, let cell = tableView.dequeueReusableCell(withIdentifier: CartViewCell.reuseID, for: indexPath) as? CartViewCell else { return .init() }
        cell.configureCell(with: books[indexPath.row])
        return cell
    }
}

extension CartViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let book = books?[indexPath.row] else { return }
        navigationController?.pushViewController(ProductViewController(book: book), animated: true)
        
    }

}
