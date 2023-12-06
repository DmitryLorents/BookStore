//
//  CartViewController.swift
//

import UIKit
import SnapKit

class CartViewController: UIViewController {
    
    // MARK: - Parameters
    
    private let viewCart = CartView()
    private var likeArray = Source.getCart()
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view = viewCart
        viewCart.transferDelegates(dataSource: self, delegate: self)
    }
}

//MARK: - Extensions
extension CartViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        likeArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CartViewCell", for: indexPath) as? CartViewCell else { fatalError() }

        cell.configureCell(likeBook: likeArray[indexPath.row])
        return cell
    }
}

extension CartViewController: UITableViewDelegate {

}
