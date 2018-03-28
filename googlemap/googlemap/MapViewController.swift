//
//  MapViewController.swift
//  googlemap
//
//  Created by 安藤輝 on 2018/03/28.
//  Copyright © 2018年 安藤輝. All rights reserved.
//

import UIKit
import GoogleMaps

class MapViewController: UIViewController {

    var locationManager: CLLocationManager!
    var mapView: GMSMapView!
    let camera = GMSCameraPosition.camera(withLatitude: 35.681167, longitude: 139.767052, zoom: 15.0)
    var myLocation: CLLocation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 位置情報許可
        locationManager = CLLocationManager()
        locationManager.delegate = self
        initMapView()
        
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            if let location = self.mapView.myLocation {
                self.myLocation = location
                let upDateCamera = GMSCameraPosition.camera(withLatitude: location.coordinate.latitude, longitude: location.coordinate.longitude, zoom: 15.0)
                self.mapView.camera = upDateCamera
            }
        }
    }
    
    private func initMapView() {
        
        mapView = GMSMapView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        mapView.camera = camera
        mapView.isMyLocationEnabled = true
        view = mapView
    }
}

extension MapViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedAlways:
            locationManager.requestWhenInUseAuthorization()
        case .authorizedWhenInUse:
            locationManager.requestWhenInUseAuthorization()
        default:
            break
        }
    }
}
