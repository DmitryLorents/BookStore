//
//  ListsViewController.swift
//  BookStore
//
//  Created by Admin on 16.12.2023.
//

import UIKit
import SnapKit

class ListViewController:UIViewController{
    
    //MARK: - Parameters
    private let listView = ListsView()
    let storageManager = StorageManagerRealm.shared
    var namesLists:[ListModel]?
    
    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        namesLists = storageManager.getListName()
    }
    
    //MARK: - Private Methods
    fileprivate func setViews(){
        view.backgroundColor = .systemBackground
        listView.transferDelegates(dataSource: self, delegate: self)
        title = "Lists"
        view = listView
        setupNavigationBar()
    }
    
    private func setupNavigationBar(){
        let navBar = navigationController?.navigationBar
        navBar?.tintColor = .black
        navBar?.backIndicatorImage = UIImage(systemName: "arrow.left")
        navBar?.backIndicatorTransitionMaskImage = UIImage(systemName: "arrow.left")
        navBar?.topItem?.backButtonTitle = ""
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .done, target: self, action: #selector(addList))
    }
    
    func addListToArr(nameList: String) {
        namesLists?.insert(ListModel(name: nameList, books: []), at: 0)
        listView.tableView.reloadData()
    }
    
    @objc private func addList(){
        let alertController = UIAlertController(title: "Add new list", message: nil, preferredStyle: .alert)

            alertController.addTextField { textField in
                textField.placeholder = "Enter list name"
        }

        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
        
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            if let text = alertController.textFields?.first?.text {
                if self.storageManager.checkDublicateList(text) {
                    let alert = UIAlertController(title: "Error", message: "List with this name already exists", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default))
                    self.present(alert, animated: true)
                }
                else{
                    self.addListToArr(nameList: text)
                    self.storageManager.addList(text)
                }
            }
        }

        alertController.addAction(cancelAction)
        alertController.addAction(okAction)

        present(alertController, animated: true, completion: nil)
    }
}

//MARK: - Extensions
extension ListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        namesLists?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ListViewCell.reuseID, for: indexPath) as? ListViewCell else { return .init() }
        
        cell.configureCell(nameList: namesLists![indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard let namesLists else { return }
        if editingStyle == .delete {
            storageManager.deleteList(namesLists[indexPath.row].name)
            self.namesLists?.remove(at: indexPath.row)
            tableView.reloadData()
        }
    }
}

extension ListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let namesLists = namesLists?[indexPath.row] else { return }
        navigationController?.pushViewController(CartViewController(books: namesLists.books, titleCart: namesLists.name, isNotLikes: true ), animated: true)
        print(namesLists)
    }
}
