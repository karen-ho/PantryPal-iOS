//
//  StoreViewController.swift
//  PantryPal-iOS
//
//  Created by Karen Ho on 10/21/18.
//  Copyright © 2018 Karen Ho. All rights reserved.
//

import Foundation
import UIKit

class StoreViewController: UIViewController {
    @IBOutlet weak var poolSearchTable: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchResultLabel: UILabel!
    @IBOutlet weak var featuredLabel: UILabel!
    
    var isSearching: Bool = false
    let poolApi = PoolApi.sharedInstance
    
    var pools: [PoolResource] = []
    let rowHeight: CGFloat = 180.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let poolNib = UINib(nibName: "PoolCell", bundle: Bundle(for: self.classForCoder))
        poolSearchTable.register(poolNib, forCellReuseIdentifier: "pool")
        
        searchBar.autocapitalizationType = .none
        
        let text = "Sort by featured"
        let textRange = NSMakeRange(0, text.count)
        let attributedText = NSMutableAttributedString(string: text)
        attributedText.addAttribute(NSAttributedString.Key.underlineStyle , value: NSUnderlineStyle.single.rawValue, range: textRange)
        // Add other attributes if needed
        self.featuredLabel.attributedText = attributedText
        
        poolApi.searchPool(searchTerm: "Diapers") { (pools) in
            self.pools = pools
            self.poolSearchTable.reloadData()
            self.searchResultLabel.text = "\(pools.count) results"
        }
    }
}

// MARK: - UITableViewDelegate
extension StoreViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let poolStoryboard = UIStoryboard(name: "PoolDetail", bundle: Bundle(for: self.classForCoder))
        let poolController = poolStoryboard.instantiateViewController(withIdentifier: "PoolDetailView") as! PoolDetailViewController
        let pool = pools[indexPath.row]
        poolController.pool = pool
        poolController.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(poolController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return rowHeight
    }
}

// MARK: - UITableViewDataSource
extension StoreViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pools.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "pool") as! PoolCell
        let pool = pools[indexPath.row]
        cell.setPool(pool, index: indexPath.row)
        cell.selectionStyle = .none
        return cell
    }
}
