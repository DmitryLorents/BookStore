//
//  CartViewController.swift
//

import UIKit
import SnapKit

protocol CartViewProtocol: AnyObject {
    func startAnimateIndicator()
    func render(_ books: [Book])
}

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
    private let hideButton:Bool
    
    // MARK: - Init
    init (books: [Book]?, titleCart: String? ,hideButton: Bool = false) {
        self.books = books
        self.titleCart = titleCart
        self.hideButton = hideButton
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
        if title == nil { books = storageManager.getFavoritesBooks() }
        cartView.checkIsEmptyBooks(books?.isEmpty ?? true)
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
        if hideButton{
            cell.crossButton.isHidden = true
        }
        else {
            cell.crossButton.tag = indexPath.row
            cell.crossButton.addTarget(self, action: #selector(crossButtonTapped), for: .touchUpInside)
        }
        return cell
    }
    
    @objc func crossButtonTapped(sender: UIButton, _ tableView: UITableView) {
        guard let books else { return }
        storageManager.deleteBook(withBook: books[sender.tag])
        self.books?.remove(at: sender.tag)
    }
    
    //FIXME: - надо скрыть менюшку с удалением
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        guard let books else { return }
//        if editingStyle == .delete {
//            storageManager.deleteBook(withBook: books[indexPath.row])
//            self.books?.remove(at: indexPath.row)
//            tableView.reloadData()
//        }
//    }
}

extension CartViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let book = books?[indexPath.row] else { return }
        navigationController?.pushViewController(ProductViewController(book: book), animated: true)
        
    }

}

extension CartViewController: CartViewProtocol {
    func startAnimateIndicator() {
        cartView.startAnimating()
    }
    
    func render(_ books: [Book]) {
        cartView.stopAnimating()
        self.books = books
    }
}
