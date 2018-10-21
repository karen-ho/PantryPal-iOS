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
    @IBOutlet weak var joinPoolButton: UIButton!
    
    var rowHeight: CGFloat = 770.0
    
    var pool: PoolResource!
    
    var quantityView: UpdateQuantityView?
    var overlayView: UIView?
    
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
        
        let tiers = pool.tiers.sorted(by: {$0.threshold < $1.threshold})
        let tier1 = tiers[0]
        let tier2 = tiers[1]
        let tier3 = tiers[2]
        
        var currentTier = 1
        
        if tier2.threshold < pool.totalUnits {
            currentTier = 2
        } else if tier3.threshold <= pool.totalUnits {
            currentTier = 3
        }
        
        if currentTier == 2 {
            let middleDiscount = (tier1.price - tier2.price) / tier1.price * 100
            let middleOff = String(format: "%.0f", middleDiscount) + "%"
            joinPoolButton.setTitle("Join Pool & Save \(middleOff)", for: .normal)
        } else if currentTier == 3 {
            let topDiscount = (tier1.price - tier3.price) / tier1.price * 100
            let topOff = String(format: "%.0f", topDiscount) + "%"
            joinPoolButton.setTitle("Join Pool & Save \(topOff)", for: .normal)
        }
        
        joinPoolButton.clipsToBounds = false
        joinPoolButton.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.16).cgColor
        joinPoolButton.layer.shadowOffset = CGSize(width: 0, height: 8)
        joinPoolButton.layer.shadowOpacity = 1
        joinPoolButton.layer.shadowRadius = 8
        
        overlayView = createOverlayView()
    }
    
    @IBAction func goBack(_ sender: UIButton) {
         navigationController?.popViewController(animated: true)
    }
    
    func addOverlay(_ overlayView: UIView) {
        view.addSubview(overlayView)
    }
    
    func showNavigationBar() {
        navigationController?.navigationBar.layer.zPosition = 1
        navigationController?.navigationBar.isUserInteractionEnabled = true
        navigationController?.navigationBar.isTranslucent = false
    }
    
    func hideNavigationBar() {
        navigationController?.navigationBar.layer.zPosition = -1
        navigationController?.navigationBar.isUserInteractionEnabled = false
        navigationController?.navigationBar.isTranslucent = true
    }
    
    @IBAction func joinPool(_ sender: UIButton) {
        if let overlayView = overlayView {
            hideNavigationBar()
            addOverlay(overlayView)
        }
        
        showQuantityView()
    }
    
    func createQuantityView() -> UpdateQuantityView {
        let quantityView = UpdateQuantityView.loadFromNibNamed("UpdateQuantityView", bundle: Bundle(for: self.classForCoder)) as! UpdateQuantityView
        quantityView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        quantityView.delegate = self
        paymentView.addSubviewAndScale(quantityView)
        return quantityView
    }
    
    func createOverlayView() -> UIView {
        let overlayView = UIView(frame: UIScreen.main.bounds)
        overlayView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.8)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(close))
        overlayView.addGestureRecognizer(tapGesture)
        return overlayView
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
    @objc func close() {
        overlayView?.removeFromSuperview()
        showNavigationBar()
        
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
        showNavigationBar()
        
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
