//
//  CustomTabBarController.swift
//  PodcastApp
//
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
        
        let homeVC = UINavigationController(rootViewController: HomeViewController(presenter: HomePresenter()))
        let categoriesVC = UINavigationController(rootViewController: CategoriesViewController())
        let likesVC = CartViewController()
        let accountVC = AccountViewController()
        
        viewControllers = [homeVC, categoriesVC, likesVC, accountVC]
        
       
    }
    
    private func setAppearance() {
        view.backgroundColor = .systemBackground
    }

}

extension CustomTabBarController: UITabBarControllerDelegate {
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
    }
    
}
