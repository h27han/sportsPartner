//
//  EventMapViewController.swift
//  sportsPartner
//
//  Created by HeFeng on 2016-01-23.
//  Copyright © 2016 waterlooHacks. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class EventMapViewController: UIViewController {

  @IBOutlet weak var mapView: MKMapView!{
    didSet {
      mapView.mapType = .Standard
      mapView.delegate = self
    }
  }
  let locationManager = CLLocationManager()
  var saveSuccessful = false
  var tapPoint:CGPoint?
  var eventTitle:String?
  
    override func viewDidLoad() {
        super.viewDidLoad()
      
      locationManager.delegate = self
      locationManager.requestAlwaysAuthorization()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
  
  @IBAction func makePost(sender: UILongPressGestureRecognizer) {
    if sender.state == .Ended {
      tapPoint = sender.locationInView(mapView);
      performSegueWithIdentifier("CreatePost", sender: self)
    }
  }
  
  @IBAction func unwindToEventMapView(segue: UIStoryboardSegue) {
    if (saveSuccessful) {
      print("aa")
      let point = mapView.convertPoint(tapPoint!, toCoordinateFromView: mapView)
      let m = MKPointAnnotation()
      m.coordinate = point
      m.title = eventTitle
      mapView.addAnnotation(m)
    }
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if (segue.identifier == "CreatePost") {
      let tableViewController = segue.destinationViewController as! CreatePostTableViewController
      tableViewController.eventLocation = mapView.userLocation.location
    }
  }
  
}

extension EventMapViewController: CLLocationManagerDelegate {
  

  
  func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
    mapView.showsUserLocation = (status == .AuthorizedAlways)
  }
}

extension EventMapViewController: MKMapViewDelegate {
  func mapView(mapView: MKMapView, didUpdateUserLocation userLocation: MKUserLocation) {
    print("got map")
    let center = CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude)
    let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
    self.mapView.setRegion(region, animated: false)
  }
}
