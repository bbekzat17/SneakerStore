//
//  TabBarController.swift
//  SneakerStore
//
//  Created by Bekzat Batyrkhanov on 07.04.2024.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.hidesBackButton = true
        
        let firstViewController = CatalogViewController()
        firstViewController.tabBarItem = UITabBarItem(title: "Catalog", image: UIImage(systemName: "house.fill"), tag: 1)
        let firstNavigationController = UINavigationController(rootViewController: firstViewController)
                
        let secondViewController = CartViewController()
        secondViewController.tabBarItem = UITabBarItem(title: "Cart", image: UIImage(systemName: "cart.fill"), tag: 2)
        let secondNavigationController = UINavigationController(rootViewController: secondViewController)
        
        let thirdViewController = ProfileViewController()
        thirdViewController.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person.crop.circle"), tag: 3)
        let thirdNavigationController = UINavigationController(rootViewController: thirdViewController)

        setViewControllers([firstNavigationController, secondNavigationController, thirdNavigationController], animated: true)
        tabBar.tintColor = .black
        tabBar.backgroundColor = .white
    }
    
    
}
