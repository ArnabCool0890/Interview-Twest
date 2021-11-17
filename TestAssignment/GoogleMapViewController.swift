//
//  GoogleMapViewController.swift
//  TestAssignment
//
//  Created by Arnab Maity on 14/11/21.
//

import UIKit
import GoogleMaps
import CoreLocation
import SVProgressHUD
class GoogleMapViewController: UIViewController {
    
    @IBOutlet weak var googleMapView: GMSMapView!
    
    var trucksArr:[TruckModels] = Array()
    var timer : Timer?
    
    var truckIdelTime = ""
    var truckLocationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        displayMarkers()

        getCurrentLocation()
        
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        timer?.invalidate()
    }
    
    
    @IBAction func backButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func openListView(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func refershAction(_ sender: UIButton) {
        truckApiCall()
    }
    
    func truckApiCall(){
        
        TruckNetworkManager.getTruckService { (truckModel,msg) in
            DispatchQueue.main.async {
                self.trucksArr = truckModel!
                
            }
        }
    }
    func displayMarkers(){
        for i in trucksArr{
            let lastCoord = i.lastRunningState
            let position = CLLocationCoordinate2D(latitude: lastCoord?.lat ?? 0, longitude: lastCoord?.lng ?? 0)
            let marker = GMSMarker(position: position)
            
            let truckTime = getcurrentdate(timeStamp: Double(i.lastRunningState?.stopStartTime ?? 0)).hours(from: Date())
            marker.title = i.truckNumber
            
            if i.lastRunningState?.truckRunningState == 1{
                marker.icon = UIImage(named: "truckGreen")
            }else if i.lastWaypoint?.ignitionOn == false &&  i.lastRunningState?.truckRunningState == 0{
                marker.icon = UIImage(named: "truckBlue")
            }else if i.lastWaypoint?.ignitionOn == true && i.lastRunningState?.truckRunningState == 0{
                marker.icon = UIImage(named: "truckYellow")
            }else if truckTime >= 4{
                marker.icon = UIImage(named: "truckRed")
            }
            
            
            
            
            let strDate = getcurrentdate(timeStamp: Double(i.lastRunningState?.stopStartTime ?? 0))
            
            self.truckIdelTime = Date().offsetFrom(from: strDate)
            
            marker.map = googleMapView
        }
    }

    
    func getcurrentdate(timeStamp :Double) -> Date {
        let time = Double(timeStamp) / 1000
        let date = Date(timeIntervalSince1970: time)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM YYYY"
        return date
    }
    
    func getCurrentLocation(){
        truckLocationManager.delegate = self
        self.truckLocationManager.requestAlwaysAuthorization()
        
        self.truckLocationManager.requestWhenInUseAuthorization()
        truckLocationManager.startUpdatingHeading()
        truckLocationManager.startUpdatingLocation()
    }
    
    
}


extension GoogleMapViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation = locations.last
        let center = CLLocationCoordinate2D(latitude: userLocation!.coordinate.latitude, longitude: userLocation!.coordinate.longitude)
        
        let camera = GMSCameraPosition.camera(withLatitude: userLocation!.coordinate.latitude, longitude: userLocation!.coordinate.longitude, zoom: 5);
        self.googleMapView.camera = camera
        self.googleMapView.isMyLocationEnabled = true
        
        let marker = GMSMarker(position: center)
        
        print("Latitude :- \(userLocation!.coordinate.latitude)")
        print("Longitude :-\(userLocation!.coordinate.longitude)")
        marker.map = self.googleMapView
        
        marker.title = "Current Location"
        truckLocationManager .stopUpdatingLocation()
        
    }
    
}
