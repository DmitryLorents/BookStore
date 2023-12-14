//
//  CartViewController.swift
//

import UIKit
import SnapKit

class CartViewController: UIViewController {
    
    // MARK: - Parameters
    
    private let viewCart = CartView()
    private var books: [Book]?
    private let storageManager = StorageManagerRealm.shared
    private let titleCart:String
    
    // MARK: - Init
    init (books: [Book]?, titleCart: String) {
        self.books = books!
        self.titleCart = titleCart
        super.init(nibName: nil, bundle: nil)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view = viewCart
        setupNavigationBar()
        viewCart.transferDelegates(dataSource: self, delegate: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        title = titleCart
        print(storageManager.getBooks())
    }
    
    //MARK: - PrivateMethods
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
        books!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CartViewCell.reuseID, for: indexPath) as? CartViewCell else { fatalError() }

        cell.configureCell(likeBook: unwrappedBook(booksWrp: books)[indexPath.row])
        return cell
    }
}

extension CartViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let book = books?[indexPath.row] else { return }
        navigationController?.pushViewController(ProductViewController(book: book), animated: true)
        
    }

}
