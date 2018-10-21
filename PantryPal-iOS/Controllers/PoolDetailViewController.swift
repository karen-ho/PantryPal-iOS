//
//  PoolDetailViewController.swift
//  PantryPal-iOS
//
//  Created by Karen Ho on 10/20/18.
//  Copyright © 2018 Karen Ho. All rights reserved.
//

import Foundation
import UIKit

class PoolDetailViewController: UIViewController {
    
    @IBOutlet weak var pluImage: UIImageView!
    @IBOutlet weak var pluNameLabel: UILabel!
    @IBOutlet weak var pluDefaultPriceLabel: UILabel!
    
    var pool: PoolResource!
    
    var quantityView: UpdateQuantityView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL(string: pool.pluImage)
        pluImage.kf.setImage(with: url)
        pluNameLabel.text = pool.pluName
        pluDefaultPriceLabel.text = "Reg \(pool.getDefaultPrice().asLocaleCurrency)"
        
        quantityView = createQuantityView()
    }
    
    @IBAction func joinPool(_ sender: UIButton) {
        showQuantityView()
    }
    
    func createQuantityView() -> UpdateQuantityView {
        let quantityView = UpdateQuantityView.loadFromNibNamed("UpdateQuantityView", bundle: Bundle(for: self.classForCoder)) as! UpdateQuantityView
        quantityView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(quantityView)
        return quantityView
    }
    
    func showQuantityView() {
        if let quantityView = quantityView {
            view.bringSubviewToFront(quantityView)
            
            quantityView.transform = CGAffineTransform(translationX: 0, y: quantityView.frame.height)
            UIView.animate(withDuration: 0.2, animations: {
                quantityView.transform = CGAffineTransform(translationX: 0, y: 0)
            })
        }
    }
}
