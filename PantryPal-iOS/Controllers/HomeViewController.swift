//
//  HomeViewController.swift
//  PantryPal-iOS
//
//  Created by Karen Ho on 10/20/18.
//  Copyright © 2018 Karen Ho. All rights reserved.
//

import Foundation
import CoreLocation
import UIKit

class HomeViewController: UIViewController {
    @IBOutlet weak var poolTable: UITableView!
    
    let locationManager: CLLocationManager = CLLocationManager()
    
    let poolApi: PoolApi = PoolApi.sharedInstance
    
    var locations: [CLLocation] = []
    var processLocationFn: Debouncer?
    
    var pools: [PoolResource] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        
        processLocationFn = Debouncer(delay: 0.5) {
            self.processLocation()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        requestLocation()
    }
    
    func getNearbyPools(location: CLLocation) {
        let latitude = location.coordinate.latitude
        let longitude = location.coordinate.longitude
        
        poolApi.getPools(latitude: latitude, longitude: longitude) { (pools) in
            self.pools = pools
            self.poolTable.reloadData()
        }
    }
}
// MARK: - CLLocationManagerDelegate
extension HomeViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .denied || status == .restricted {
            // show no location services
            
        } else if status == .authorizedAlways || status == .authorizedWhenInUse {
            locationManager.requestLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("failed to get location for \(error)")
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.locations = locations
        
        processLocationFn?.call()
    }
    
    @objc func processLocation() {
        if let location = locations.first {
            getNearbyPools(location: location)
        }
    }
    
    func requestLocation() {
        if hasEnabledLocationServices() {
            if !hasEnabledLocation() {
                if hasRequestedLocationAuthorization() {
                    // show no location available
                } else {
                    requestLocationPermission()
                }
            } else {
                // get current location
                locationManager.requestLocation()
            }
        } else {
            // show no location available
        }
    }
    
    func requestLocationPermission() {
        locationManager.requestWhenInUseAuthorization()
    }
    
    func hasEnabledLocationServices() -> Bool {
        return type(of: locationManager).locationServicesEnabled()
    }
    
    func hasEnabledLocation() -> Bool {
        return type(of: locationManager).authorizationStatus() == .authorizedWhenInUse
    }
    
    func hasRequestedLocationAuthorization() -> Bool {
        return type(of: locationManager).authorizationStatus() != .notDetermined
    }
}

// MARK: - UITableViewDelegate
extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let poolStoryboard = UIStoryboard(name: "PoolDetail", bundle: Bundle(for: self.classForCoder))
        let poolController = poolStoryboard.instantiateViewController(withIdentifier: "PoolDetailView") as! PoolDetailViewController
        navigationController?.pushViewController(poolController, animated: true)
    }
}

// MARK: - UITableViewDataSource
extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pools.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }

}
