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
            guard let books else {return}
            cartView.reloadTableView()
            cartView.hideLabelAndImage(!books.isEmpty)
        }
    }
    private let storageManager = StorageManagerRealm.shared
    private let titleCart:String?
    private let isHideCrossButton:Bool
    private let isNotLikes:Bool
    
    // MARK: - Init
    init (books: [Book]?, titleCart: String? ,isHideCrossButton: Bool = false, isNotLikes:Bool = false) {
        self.books = books
        self.titleCart = titleCart
        self.isHideCrossButton = isHideCrossButton
        self.isNotLikes = isNotLikes
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
        if title == nil {
            books = storageManager.getFavoritesBooks()
            //cartView.hideLabelAndImage((books?.isEmpty) ?? false)
        } else {
            cartView.hideLabelAndImage(true)
        }
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
        if isHideCrossButton{
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
        
        if self.isNotLikes, let titleCart {
            storageManager.deleteBookFromList(books[sender.tag], listName: titleCart)
            self.books?.remove(at: sender.tag)
        }
        else {
            storageManager.deleteBook(books[sender.tag])
            self.books?.remove(at: sender.tag)
        }
    }
    
    //FIXME: - надо скрыть менюшку с удалением
//        func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//            guard let books else { return }
//            if editingStyle == .delete {
//                storageManager.deleteBook(books[indexPath.row])
//                self.books?.remove(at: indexPath.row)
//                tableView.reloadData()
//            }
//        }
}

extension CartViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let book = books?[indexPath.row] else { return }
        if let navigationController = navigationController {
            navigationController.pushViewController(ProductViewController(book: book), animated: true)
        } else {
            present(ProductViewController(book: book), animated: true)
        }
        
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
