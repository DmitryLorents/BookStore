//
//  CustomTabBarController.swift
//  BookStore
//
//  Created by Andrei Shpartou on 8/12/2023.
//

import UIKit

class CustomTabBarController: UITabBarController {

    let storageManager = StorageManagerRealm.shared
    
    //MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setControllers()
        setAppearance()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let screenHeight = UIScreen.main.bounds.size.height
        let tabBarHeight = screenHeight * 0.12
        var tabFrame = tabBar.frame
        tabFrame.size.height = tabBarHeight
        tabFrame.origin.y = view.frame.size.height - tabBarHeight
        tabBar.frame = tabFrame
    }
    
   //MARK: Methods
    private func setControllers() {
        let homeVC = generateVC(
            viewController: .homeBuilder,
            image: UIImage(named: "homeUnselected"),
            selectedImage: UIImage(named: "homeSelected"))
        
        let categoriesVC = generateVC(
            viewController: CategoriesViewController(),
            image: UIImage(named: "categoriesUnselected"),
            selectedImage: UIImage(named: "categoriesSelected"))
        
        let likesVC = generateVC(
            //TODO: - в бук другую модель поставить
            viewController: CartViewController(books: storageManager.getFavoritesBooks(), titleCart: nil),
            image: UIImage(named: "likesUnselected"),
            selectedImage: UIImage(named: "likesSelected"))
        
        let accountVC = generateVC(
            viewController: AccountViewController(),
            image: UIImage(named: "accountUnselected"),
            selectedImage: UIImage(named: "accountSelected"))
        
        viewControllers = [
            UINavigationController(rootViewController: homeVC),
            UINavigationController(rootViewController: categoriesVC),
            UINavigationController(rootViewController: likesVC),
            UINavigationController(rootViewController: accountVC)
        ]
    }
    // generate View Controller
    private func generateVC(viewController: UIViewController, image: UIImage?, selectedImage: UIImage?) -> UIViewController {
        viewController.tabBarItem = UITabBarItem(
            title: nil,
            image: image?.withRenderingMode(.alwaysOriginal),
            selectedImage: selectedImage?.withRenderingMode(.alwaysOriginal))
        
        viewController.tabBarItem.imageInsets = UIEdgeInsets(top: 10, left: 0, bottom: -10, right: 0)
        return viewController
    }
    
    private func setAppearance() {
        let tabBarAppearance: UITabBarAppearance = UITabBarAppearance()
        tabBarAppearance.configureWithDefaultBackground()
        tabBarAppearance.backgroundColor =  #colorLiteral(red: 0.9008976817, green: 0.9008975625, blue: 0.9008976221, alpha: 1)
        UITabBar.appearance().standardAppearance = tabBarAppearance
        UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
    }
}

extension CustomTabBarController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
    }
}
