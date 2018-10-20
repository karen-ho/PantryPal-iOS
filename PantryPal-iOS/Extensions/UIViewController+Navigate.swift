//
//  UIViewController+Navigate.swift
//  PantryPal-iOS
//
//  Created by Karen Ho on 10/20/18.
//  Copyright © 2018 Karen Ho. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    func goToTabBar() {
        let tabStoryboard = UIStoryboard(name: "Tab", bundle: Bundle(for: self.classForCoder))
        let tabController = tabStoryboard.instantiateViewController(withIdentifier: "TabView") as! TabViewController
        UIApplication.shared.keyWindow?.rootViewController = tabController
    }
}
