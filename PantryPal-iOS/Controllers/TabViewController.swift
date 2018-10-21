//
//  TabViewController.swift
//  PantryPal-iOS
//
//  Created by Karen Ho on 10/20/18.
//  Copyright © 2018 Karen Ho. All rights reserved.
//

import Foundation
import UIKit

class TabViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
        
        let storeStoryboard = UIStoryboard(name: "Store", bundle: Bundle(for: self.classForCoder))
        let storeController = storeStoryboard.instantiateViewController(withIdentifier: "StoreView") as!StoreViewController
        let storeNavController = UINavigationController(rootViewController: storeController)
        storeNavController.tabBarItem = UITabBarItem(title: "Store", image: UIImage(assetIdentifier: .shop), selectedImage: UIImage(assetIdentifier: .shop))

        let homeStoryboard = UIStoryboard(name: "Home", bundle: Bundle(for: self.classForCoder))
        let homeController = homeStoryboard.instantiateViewController(withIdentifier: "HomeView") as! HomeViewController
        let homeNavController = UINavigationController(rootViewController: homeController)
        homeNavController.tabBarItem = UITabBarItem(title: "My Pools", image: UIImage(assetIdentifier: .pools), selectedImage: UIImage(assetIdentifier: .pools))
        
        let searchStoryboard = UIStoryboard(name: "Search", bundle: Bundle(for: self.classForCoder))
        let searchController = searchStoryboard.instantiateViewController(withIdentifier: "SearchView") as! SearchViewController
        let searchNavController = UINavigationController(rootViewController: searchController)
        searchNavController.tabBarItem = UITabBarItem(title: "Wallet", image: UIImage(assetIdentifier: .wallet), selectedImage: UIImage(assetIdentifier: .wallet))
        
        let settingStoryboard = UIStoryboard(name: "Setting", bundle: Bundle(for: self.classForCoder))
        let settingController = settingStoryboard.instantiateViewController(withIdentifier: "SettingView") as! SettingViewController
        let settingNavController = UINavigationController(rootViewController: settingController)
        settingNavController.tabBarItem = UITabBarItem(title: "Account", image: UIImage(assetIdentifier: .account), selectedImage: UIImage(assetIdentifier: .account))
        
        viewControllers = [storeNavController, homeNavController, searchNavController, settingNavController]
    }
}

// MARK: - UITabBarControllerDelegate
extension TabViewController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        if let viewController = viewController as? UINavigationController {
            viewController.popToRootViewController(animated: false)
        }
    }
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertToOptionalNSAttributedStringKeyDictionary(_ input: [String: Any]?) -> [NSAttributedString.Key: Any]? {
    guard let input = input else { return nil }
    return Dictionary(uniqueKeysWithValues: input.map { key, value in (NSAttributedString.Key(rawValue: key), value)})
}
