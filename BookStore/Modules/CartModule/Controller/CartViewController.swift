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
    
    // MARK: - Init
    init (books: [Book]?){
        self.books = books!
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
        viewCart.transferDelegates(dataSource: self, delegate: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
}

//MARK: - Extensions
extension CartViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        books!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CartViewCell.reuseID, for: indexPath) as? CartViewCell else { fatalError() }

        cell.configureCell(likeBook: books![indexPath.row])
        return cell
    }
}

extension CartViewController: UITableViewDelegate {

}
