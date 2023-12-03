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
       
    }
    
    private func setAppearance() {
        
    }

}

extension CustomTabBarController: UITabBarControllerDelegate {
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
    }
    
}
