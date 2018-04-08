//
//  MapViewController.swift
//  googlemap
//
//  Created by 安藤輝 on 2018/03/28.
//  Copyright © 2018年 安藤輝. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces

class MapViewController: UIViewController {
    
    struct Defaults {
        static let zoom = Float(15.0)
        static let placeholder = "緯度,経度を入力してください"
    }
    
    var locationManager: CLLocationManager!
    var currentLocation = CLLocationCoordinate2D(latitude: CLLocationDegrees(35.681167), longitude: CLLocationDegrees(139.767052))
    var tokyoLocation = CLLocationCoordinate2D(latitude: CLLocationDegrees(35.681167), longitude: CLLocationDegrees(139.767052))
    
    var mapView: GMSMapView!
    var searchBar = UISearchBar(frame: CGRect(x: 0, y: UIApplication.shared.statusBarFrame.height, width: UIScreen.main.bounds.width, height: 30))
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // 位置情報許可
        locationManager = CLLocationManager()
        locationManager.delegate = self

        startCurrentLoction()
        initMapView()
        initSeachBar()
        
        // currentLocationが確定してから実行したい
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.mapView.camera = GMSCameraPosition.camera(withTarget: self.currentLocation, zoom: Defaults.zoom)
            self.setDummyMarker()
            self.setDummyPolyline()
        }
    }
    
    private func initMapView() {
        
        mapView = GMSMapView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
        
        view.addSubview(mapView)
    }
    
    private func initSeachBar() {

        searchBar.delegate = self
        searchBar.placeholder = Defaults.placeholder
        searchBar.showsScopeBar = true
        view.addSubview(searchBar)
    }
    
    private func startCurrentLoction() {
        
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            if let coordinate = self.mapView.myLocation?.coordinate {
                self.currentLocation = coordinate
            }
        }
    }
    
    private func setDummyMarker() {
        
        let dummyMarker = GMSMarker(position: tokyoLocation)
        dummyMarker.map = mapView
    }
    
    private func setDummyPolyline() {
        
        let path = GMSMutablePath()
        path.add(currentLocation)
        path.add(tokyoLocation)
        
        let polyline = GMSPolyline(path: path)
        polyline.strokeColor = .blue
        polyline.strokeWidth = 5.0
        polyline.map = mapView
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

extension MapViewController: UISearchBarDelegate {
    
    // 検索を押された
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        print("検索")
    }
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.showsCancelButton = true
        return true
    }
    
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.showsCancelButton = false
        return true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {        
        searchBar.endEditing(true)
    }
}
