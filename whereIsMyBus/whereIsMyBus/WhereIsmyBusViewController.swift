

import UIKit
import GoogleMaps
import Firebase
import CoreLocation

class WhereIsmyBusViewController: UIViewController , CLLocationManagerDelegate {

    var locationManager: CLLocationManager!
    var mapView: GMSMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        let mapView = GMSMapView.init();
        mapView.myLocationEnabled = true
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        
        mapView.camera = GMSCameraPosition.cameraWithLatitude(18.8583021,longitude: -69.7292113, zoom: 9);
        
        mapView.padding = UIEdgeInsets(top: 100.0, left: 0.0, bottom: 0.0, right: 300.0)
        
        if let mylocation = mapView.myLocation {
            
            mapView.camera = GMSCameraPosition.cameraWithLatitude(mylocation.coordinate.latitude,longitude: mylocation.coordinate.longitude, zoom: 6);
           
        }
        
        self.view = mapView
        
        
 
        
        let refHandle =  FIRDatabase.database().reference()
        
         refHandle.observeEventType(FIRDataEventType.Value, withBlock: { (snapshot) in
            let busesDict = snapshot.value as! [String : AnyObject]
            mapView.clear()
          
            for (key,value) in busesDict["busses"] as! [String:AnyObject] {
               
                let marker = GMSMarker()
                marker.position = CLLocationCoordinate2DMake((value["latitude"] as? Double)!, (value["longitude"] as? Double)!)
                marker.title = value["name"] as? String
                //marker.snippet = "Australia"
                marker.icon = UIImage(named: "ic_google_map_marker")
                marker.map = mapView
                
                
                print("\(key) -> \(value["name"]!!)")
            
               
            }
            
                       
        })
    }

    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if status == .AuthorizedAlways {
            if CLLocationManager.isMonitoringAvailableForClass(CLBeaconRegion.self) {
                if CLLocationManager.isRangingAvailable() {
                    
                    
                    mapView.camera = GMSCameraPosition.cameraWithLatitude((locationManager.location?.coordinate.latitude)!,longitude: (locationManager.location?.coordinate.longitude)!, zoom: 6);
                    
                    
                }
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

