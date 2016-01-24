//
//  SearchController.swift
//  sportsPartner
//
//  Created by Dixon Cheung on 2016-01-23.
//  Copyright © 2016 waterlooHacks. All rights reserved.
//

import UIKit
import Parse
import CoreLocation
import MapKit

class MyAnnotation: NSObject, MKAnnotation {
    init(coordinate:CLLocationCoordinate2D) {
        self.coordinate = coordinate
    }
    var coordinate: CLLocationCoordinate2D
    var id :String?
    var title : String?
    var subtitle : String?
    var activity : String?
}

class SearchController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {

    
    @IBOutlet weak var filterTable: UITableView!
    @IBOutlet weak var mapView: MKMapView!
    
    var locationManager : CLLocationManager!;
    var prevCLLocation : CLLocation!;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.distanceFilter = kCLDistanceFilterNone;
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        //locationManager.startMonitoringSignificantLocationChanges()
        
        mapView.delegate = self
        mapView.showsUserLocation = true
        
        
        // Do any additional setup after loading the view.
    }

    @IBAction func filters(sender: AnyObject) {
        filterTable.hidden = (filterTable.hidden==true) ? false : true
    }
    
    func locationManager(manager: CLLocationManager, didUpdateToLocation newLocation: CLLocation, fromLocation oldLocation: CLLocation)
    {
        let location = newLocation
        let lat = location.coordinate.latitude
        let long = location.coordinate.longitude
        
        if(oldLocation.coordinate.latitude==lat && oldLocation.coordinate.longitude==long) {
            return;
        }
        /*
        if(prevCLLocation != nil && prevCLLocation.coordinate.latitude == lat && prevCLLocation.coordinate.longitude == long) {
            return;
        }
        prevCLLocation = CLLocation(latitude: lat, longitude: long)
*/
        
        let center = CLLocationCoordinate2D(latitude: lat, longitude: long)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        
        self.mapView.setRegion(region, animated: true)
        
        let query = PFQuery(className: "Events")
        query.whereKey("location", nearGeoPoint: PFGeoPoint(latitude: lat, longitude: long), withinKilometers: 2)
        /*
        if(activity.characters.count > 0) {
            query.whereKey("Activity", equalTo: activity)
        }
        if(limit < 1) {
            query.limit = 20
        } else {
            query.limit = limit
        }
*/
        query.findObjectsInBackgroundWithBlock { (objects: [PFObject]?, error: NSError?) -> Void in
            if error == nil {
                if let objects = objects {
                    for object in objects {
                        // Do something
                        let geoPoint = object["location"] as! PFGeoPoint
                        
                        let myPoint = MyAnnotation(coordinate: CLLocationCoordinate2DMake(geoPoint.latitude, geoPoint.longitude))
                        myPoint.title = object["title"] as? String
                        myPoint.subtitle = object["description"] as? String
                        myPoint.id = object.objectId
                        print("ID \(myPoint.id)")
                        myPoint.activity = object["activity"] as? String
                        
                        self.mapView.addAnnotation(myPoint)
                    }
                }
            } else {
                print(error)
            }
        }
    }
    
    func mapView(mapView: MKMapView, didSelectAnnotationView view: MKAnnotationView) {
        print("You clicked some shit")
        if(view.annotation is MyAnnotation) {
            print("oooo that's prtty nice I still have good info")
        }
    }
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        if (annotation is MKUserLocation) {
            //if annotation is not an MKPointAnnotation (eg. MKUserLocation),
            //return nil so map draws default view for it (eg. blue dot)...
            return nil
        }
        
        let reuseId = (annotation as! MyAnnotation).id
        
        var anView = mapView.dequeueReusableAnnotationViewWithIdentifier(reuseId!)
        if anView == nil {
            anView = MKAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            //anView!.animatesDrop = true
            
            // Add a detail disclosure button to the callout.
            let rightButton = UIButton(type: UIButtonType.ContactAdd)
            rightButton.addTarget(self, action: "joinEvent:", forControlEvents: UIControlEvents.TouchUpInside)
            anView!.rightCalloutAccessoryView = rightButton;
            if annotation.isKindOfClass(MyAnnotation)
            {
                let annotation = annotation as! MyAnnotation
                print("FOUND OUR CustomMapPinAnnotation CLASS IN mapView")
                print(" Custom Title = \(annotation.title)")
                print(" Custom Subtitle = \(annotation.subtitle)")
                print(" Custom Activity = \(annotation.activity)")
                if(annotation.activity == "Badminton") {
                    anView!.image = UIImage(named: "Badminton-48.png")
                } else if (annotation.activity == "Basketball") {
                    anView!.image = UIImage(named: "Basketball-48.png")
                } else if (annotation.activity == "Baseball") {
                    anView!.image = UIImage(named: "Baseball-48.png")
                } else if (annotation.activity == "Tennis") {
                    anView!.image = UIImage(named: "Tennis-48.png")
                } else if (annotation.activity == "Ultimate Frisbee" ) {
                    anView!.image = UIImage(named: "Frisbess-48.png")
                } else if (annotation.activity == "Soccer") {
                    anView!.image = UIImage(named: "Football-48.png")
                }
            }  // if
            anView!.canShowCallout = true
        }
        else {
            //we are re-using a view, update its annotation reference...
            anView!.annotation = annotation
        }
        
        return anView
    }
    
    @IBAction func joinEvent ( sender:AnyObject) {
        print("You wanted to join the Event. Too bad not yet!!!")
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
