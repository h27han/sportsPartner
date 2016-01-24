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
    
    func editEvent(eventId:String, username:String, title:String, description:String, maxParticipants:Int, activity:String, startTime:NSDate, endTime:NSDate, location:CLLocation) {
        let query = PFQuery(className: "Events")
        query.getObjectInBackgroundWithId(eventId) {
            (entry : PFObject?, error: NSError?) -> Void in
            if error != nil {
                print(error);
            } else {
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
    
    func getRating(username:String) {
        let query = PFQuery(className: "Ratings")
        query.whereKey("username", equalTo: username)
        query.findObjectsInBackgroundWithBlock { (objects: [PFObject]?, error: NSError?) -> Void in
            if error != nil {
                print(error);
            } else {
                if let objects = objects {
                    var sum = 0;
                    for object in objects {
                        sum += object.valueForKey("Rating") as! Int!
                    }
                    var avg : Float
                    avg = Float(sum) / Float(objects.count)
                }
            }
        }
    }
    
    func findLocalEvents(location:CLLocation, distance:Double, limit:Int, activity:String) {
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
        query.findObjectsInBackgroundWithBlock { (objects: [PFObject]?, error: NSError?) -> Void in
            if error == nil {
                if let objects = objects {
                    for object in objects {
                        // Do something
                    }
                }
            } else {
                print(error)
            }
        }
    }
    
    func getEvent(eventId:String) {
        let query = PFQuery(className: "Events")
        query.whereKey("objectId", equalTo: eventId)
        query.findObjectsInBackgroundWithBlock { (objects: [PFObject]?, error: NSError?) -> Void in
            if error == nil {
                if let objects = objects {
                    for object in objects {
                        // Do something
                    }
                }
            } else {
                print(error)
            }
        }
    }
    
    func getAttendingEvents(username:String) {
        let query = PFQuery(className: "Participates")
        query.whereKey("username", equalTo: username)
        query.findObjectsInBackgroundWithBlock { (objects: [PFObject]?, error: NSError?) -> Void in
            if error == nil {
                if let objects = objects {
                    for object in objects { 
                    }
                }
            } else {
                print(error)
            }
        }
    }
    
    func getHostedEvents(username:String) {
        let query = PFQuery(className: "")
        query.whereKey("username", equalTo: username)
        query.findObjectsInBackgroundWithBlock { (objects: [PFObject]?, error: NSError?) -> Void in
            if error == nil {
                if let objects = objects {
                    for object in objects {
                        // Do something
                    }
                }
            } else {
                print(error)
            }
        }
    }
    
    func signUp(name:String, password:String, email:String)->Bool {
        //1
        let user = PFUser()
        
        print(user.username)
        var status = true
		
        //2
        user.username = name
        user.password = password
        user.email = email
        
        //3
        user.signUpInBackgroundWithBlock { succeeded, error in
            if (succeeded) {
            //The registration was successful, go to the wall
            //self.performSegueWithIdentifier(self.scrollViewWallSegue, sender: nil)
				status = true
				
                print("Sign Up Successful")
            } else if let error = error {
				status = false
            //Something bad has occurred
            //self.showErrorView(error)
                print("Sign Up Failed")
			
            }
        }
		return status;
    }
    
	 func login(username:String, password:String)->Bool{
		var status = false;
        PFUser.logInWithUsernameInBackground(username, password: password) { user, error in
            if user != nil {
                //self.performSegueWithIdentifier(self.scrollViewWallSegue, sender: nil)
                print("Login Successful")
				status = true;
				
            } else if let error = error {
                //self.showErrorView(error)
                print("Login Failed")
				status = false;
				
				
            }
        }
		return status
    }
	
}