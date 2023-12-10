//
//  CustomTabBarController.swift
//  BookStore
//
//  Created by Andrei Shpartou on 8/12/2023.
//

import UIKit

class CustomTabBarController: UITabBarController {

    //MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setControllers()
        setAppearance()
    }
    
   //MARK: Methods
    private func setControllers() {
        let homeVC = generateVC(
            viewController: HomeViewController(sections: BookModel.sections),
            image: UIImage(named: "homeUnselected"),
            selectedImage: UIImage(named: "homeSelected"))
        
        let categoriesVC = generateVC(
            viewController: CategoriesViewController(),
            image: UIImage(named: "categoriesUnselected"),
            selectedImage: UIImage(named: "categoriesSelected"))
        
        let likesVC = generateVC(
            viewController: CartViewController(),
            image: UIImage(named: "likesUnselected"),
            selectedImage: UIImage(named: "likesSelected")?.withRenderingMode(.alwaysOriginal))
            
        //let accountVC = generateVC(
            //                viewController: AccountViewController(),
            //                image: UIImage(named: "likesUnsecected")
        
        viewControllers = [
            UINavigationController(rootViewController: homeVC),
            UINavigationController(rootViewController: categoriesVC),
            likesVC
        ]
    }
    
    private func generateVC(viewController: UIViewController, image: UIImage?, selectedImage: UIImage?) -> UIViewController {
        viewController.tabBarItem = UITabBarItem(title: "", image: image, selectedImage: selectedImage)
        return viewController
    }
    
    private func setAppearance() {
        view.backgroundColor = .systemBackground
    }

}

extension CustomTabBarController: UITabBarControllerDelegate {
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
    }
    
}
