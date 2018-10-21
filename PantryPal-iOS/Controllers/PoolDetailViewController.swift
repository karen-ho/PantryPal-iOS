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
    
    @IBOutlet weak var paymentView: UIView!
    @IBOutlet weak var productTable: UITableView!
    
    var rowHeight: CGFloat = 770.0
    
    var pool: PoolResource!
    
    var quantityView: UpdateQuantityView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        quantityView = createQuantityView()
        
        paymentView.clipsToBounds = false
        paymentView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.16).cgColor
        paymentView.layer.shadowOffset = CGSize(width: 0, height: 20)
        paymentView.layer.shadowOpacity = 1
        paymentView.layer.shadowRadius = 20
        
        let productDetailNib = UINib(nibName: "ProductDetailCell", bundle: Bundle(for: self.classForCoder))
        productTable.register(productDetailNib, forCellReuseIdentifier: "productDetail")
    }
    
    @IBAction func joinPool(_ sender: UIButton) {
        showQuantityView()
    }
    
    func createQuantityView() -> UpdateQuantityView {
        let quantityView = UpdateQuantityView.loadFromNibNamed("UpdateQuantityView", bundle: Bundle(for: self.classForCoder)) as! UpdateQuantityView
        quantityView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        quantityView.delegate = self
        paymentView.addSubview(quantityView)
        return quantityView
    }
    
    func showQuantityView() {
        view.bringSubviewToFront(paymentView)

        paymentView.transform = CGAffineTransform(translationX: 0, y: paymentView.frame.height)
        paymentView.isHidden = false
        UIView.animate(withDuration: 0.2, animations: {
            self.paymentView.transform = CGAffineTransform(translationX: 0, y: 0)
        })
    }
}

// MARK: -
extension PoolDetailViewController: QuantityDelegate {
    func close() {
        UIView.animate(withDuration: 0.2, animations: {
            self.paymentView.transform = CGAffineTransform(translationX: 0, y: +self.paymentView.frame.height)
        }, completion: { completed in
            self.paymentView.isHidden = true
        })
    }
    
    func proceed(quantity: Int) {
        let checkoutStoryboard = UIStoryboard(name: "Checkout", bundle: Bundle(for: self.classForCoder))
        let checkoutController = checkoutStoryboard.instantiateViewController(withIdentifier: "CheckoutView") as! CheckoutViewController
        checkoutController.pool = pool
        checkoutController.quantity = quantity
        navigationController?.pushViewController(checkoutController, animated: true)
    }
}

// MARK: -
extension PoolDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return rowHeight
    }
}

// MARK: -
extension PoolDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "productDetail") as! ProductDetailCell
        cell.setProduct(pool: pool)
        cell.selectionStyle = .none
        return cell
    }
}
