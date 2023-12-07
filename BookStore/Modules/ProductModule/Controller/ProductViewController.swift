//
//  ProductViewController.swift
//  BookStore
//
//  Created by Andrei Shpartou on 5/12/2023.
//

import UIKit

class ProductViewController: UIViewController {
    //MARK: - Parameters
    private let productView = ProductView()
    
    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view = productView
    }
    
    //MARK: - Methods
    
}
