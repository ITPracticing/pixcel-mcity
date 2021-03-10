//
//  MapVC.swift
//  pixel-mcity
//
//  Created by F_OS on 3/10/21.
//  Copyright © 2021 F_OS. All rights reserved.
//

import UIKit
import Alamofire
import MapKit
import CoreLocation

class MapVC: UIViewController {

    // Outlet
    @IBOutlet weak var mapView: MKMapView!
    let authorizationSatus = CLLocationManager.authorizationStatus()
    
    // var
    var locationManager = CLLocationManager()
    let regionRadius: Double = 1000
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        locationManager.delegate = self
        configureLocationServices()

    }
    

    @IBAction func centerMapBtnPressed(_ sender: Any) {
    }
    
}


extension MapVC: MKMapViewDelegate {
    
    func centerMapOnUserLocation() {
        guard let coordinate = locationManager.location?.coordinate else { return}
        let coordinateRegion = MKCoordinateRegion(center: coordinate, latitudinalMeters: regionRadius * 2.0 , longitudinalMeters: regionRadius * 2.0)
            mapView.setRegion(coordinateRegion, animated: true)
        
    }
    
}

extension MapVC: CLLocationManagerDelegate {
    
    func configureLocationServices() {
        
        if authorizationSatus == .notDetermined {
            locationManager.requestAlwaysAuthorization()
        } else {
            return
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        centerMapOnUserLocation()
    }
}
