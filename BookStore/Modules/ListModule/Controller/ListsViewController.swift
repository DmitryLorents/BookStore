//
//  ListsViewController.swift
//  BookStore
//
//  Created by Admin on 16.12.2023.
//

import UIKit
import SnapKit

class ListsViewController:UIViewController{
    
    private let listView = ListsView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view = listView
    }
}
