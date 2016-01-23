//
//  DAL.swift
//  sportsPartner
//
//  Created by Dixon Cheung on 2016-01-23.
//  Copyright © 2016 waterlooHacks. All rights reserved.
//

import Foundation
import Parse

class DAL {
    
    func test() {
        let testObject = PFObject(className: "Events")
        let startDate = NSDate()
        let endDate = NSDate()
        testObject.setObject(PFGeoPoint(latitude: 40.001, longitude: -80.0), forKey: "location")
        testObject.setObject(startDate, forKey: "startTime")
        testObject.setObject(endDate, forKey: "endTime")
        testObject.setObject("user1", forKey: "userCreated")
        testObject.setObject("", forKey: "title")
        testObject.setObject("", forKey: "description")
        testObject.setObject(0, forKey: "maxParticipants")
        testObject.setObject("Badminton", forKey: "activities")
        testObject.saveInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
            print("Object has been saved.")
        }
    }
    
    func createEvent(username:String, title:String, description:String, maxParticipants:Int, activity:String, startTime:NSDate, endTime:NSDate, location:CLLocation) {
        let entry = PFObject(className: "Events")
        entry.setObject(username, forKey: "userCreated")
        entry.setObject(title, forKey: "title")
        entry.setObject(description, forKey: "description")
        entry.setObject(maxParticipants, forKey: "maxParticipants")
        entry.setObject(activity, forKey: "activities")
        entry.setObject(startTime, forKey: "startTime")
        entry.setObject(endTime, forKey: "endTime")
        entry.setObject(PFGeoPoint(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude), forKey: "location")
        entry.saveInBackgroundWithBlock {(success:Bool, error:NSError?) -> Void in
            
        }
    }
    
    func joinEvent(eventID:String, username: String) {
        let entry = PFObject(className: "Participants")
        entry.setObject(eventID, forKey: "eventId")
        entry.setObject(username, forKey: "username")
        entry.saveInBackgroundWithBlock {(success:Bool, error:NSError?) -> Void in
            
        }
    }
    
    func findLocalEvents(location:CLLocation, distance:Double, limit:Int, activity:String) throws -> NSArray {
        let query = PFQuery(className: "Events")
        query.whereKey("location", nearGeoPoint: PFGeoPoint(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude), withinKilometers: distance)
        if(activity.characters.count > 0) {
            query.whereKey("Activity", equalTo: activity)
        }
        if(limit < 1) {
            query.limit = 20
        } else {
            query.limit = limit
        }
        return try query.findObjects();
    }
    
    func getEvent(eventId:String) throws -> NSArray {
        let query = PFQuery(className: "Events")
        query.whereKey("objectId", equalTo: eventId)
        return try query.findObjects()
    }
    
    func getAttendingEvents(username:String) throws -> NSArray {
        let query = PFQuery(className: "Participates")
        query.whereKey("username", equalTo: username)
        return try query.findObjects()
    }
    
    func getHostedEvents(username:String) throws -> NSArray {
        let query = PFQuery(className: "")
        query.whereKey("username", equalTo: username)
        let res = try query.findObjects()
        return res
    }
    
    func signUp(name:String, password:String, email:String) {
        //1
        let user = PFUser()
        
        //2
        user.username = name
        user.password = password
        user.email = email
        
        //3
        user.signUpInBackgroundWithBlock { succeeded, error in
            if (succeeded) {
            //The registration was successful, go to the wall
            //self.performSegueWithIdentifier(self.scrollViewWallSegue, sender: nil)
                print("Sign Up Successful")
            } else if let error = error {
            //Something bad has occurred
            //self.showErrorView(error)
                print("Sign Up Failed")
            }
        }
    }
    
    func login(username:String, password:String) {
        PFUser.logInWithUsernameInBackground(username, password: password) { user, error in
            if user != nil {
                //self.performSegueWithIdentifier(self.scrollViewWallSegue, sender: nil)
                print("Login Successful")
            } else if let error = error {
                //self.showErrorView(error)
                print("Login Failed")
            }
        }
    }
}