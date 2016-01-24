//
//  EventDetailed.swift
//  sportsPartner
//
//  Created by Dixon Cheung on 2016-01-24.
//  Copyright © 2016 waterlooHacks. All rights reserved.
//

import UIKit
import Foundation
import Parse

class EventDetailed: UIViewController {

    var toPass:String!
    
    @IBOutlet weak var addressValue: UILabel!
    @IBOutlet weak var endValue: UILabel!
    @IBOutlet weak var startValue: UILabel!
    @IBOutlet weak var numParticipantsValue: UILabel!
    @IBOutlet weak var activityValue: UILabel!
    @IBOutlet weak var descriptionValue: UILabel!
    @IBOutlet weak var titleValue: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let query = PFQuery(className: "Events")
        query.whereKey("objectId", equalTo: toPass)
        query.findObjectsInBackgroundWithBlock { (objects: [PFObject]?, error: NSError?) -> Void in
            if error == nil {
                if let objects = objects {
                    for object in objects {
                        let geoPoint = object["location"] as! PFGeoPoint
                        
                        let postEndpoint: String = "https://maps.googleapis.com/maps/api/geocode/json?latlng=\(geoPoint.latitude),\(geoPoint.longitude)&location_type=ROOFTOP&result_type=street_address&key=AIzaSyChOu_1CSmUTUHJ_RAspg_IjSRTsabhQ4U"
                        guard let url = NSURL(string: postEndpoint) else {
                            print("Error: cannot create URL")
                            return
                        }
                        let urlRequest = NSURLRequest(URL: url)
                        let config = NSURLSessionConfiguration.defaultSessionConfiguration()
                        let session = NSURLSession(configuration: config)
                        let task = session.dataTaskWithRequest(urlRequest, completionHandler: { (data, response, error) in
                            // do stuff with response, data & error here
                            guard let responseData = data else {
                                print("Error: did not receive data")
                                return
                            }
                            guard error == nil else {
                                print("error calling GET on /posts/1")
                                print(error)
                                return
                            }
                            // parse the result as JSON, since that's what the API provides
                            let post: NSDictionary
                            do {
                                post = try NSJSONSerialization.JSONObjectWithData(responseData, 
                                    options: []) as! NSDictionary
                            } catch  {
                                print("error trying to convert data to JSON")
                                return
                            }
                            self.addressValue.text = post["results"]![0]["formatted_address"] as? String
                        })
                        task.resume()
                        
                        // Do something
                        self.titleValue.text = object["title"] as! String
                        self.descriptionValue.text = object["description"] as! String
                        self.activityValue.text = object["activity"] as! String
                        let startTime = object["startTime"] as! NSDate
                        let endTime = object["endTime"] as! NSDate
                        
                        let myDateFormatter = NSDateFormatter()
                        myDateFormatter.dateStyle = NSDateFormatterStyle.LongStyle
                        myDateFormatter.timeStyle = NSDateFormatterStyle.MediumStyle
                        self.startValue.text = myDateFormatter.stringFromDate(startTime)
                        self.endValue.text = myDateFormatter.stringFromDate(endTime)
                        
                        
                    }
                }
            } else {
                print(error)
            }
        }
        
        let q2 = PFQuery(className: "Events")
        q2.whereKey("eventId", equalTo: toPass)
        q2.findObjectsInBackgroundWithBlock { (objects: [PFObject]?, error: NSError?) -> Void in
            if error == nil {
                if let objects = objects {
                    self.numParticipantsValue.text = String(objects.count)
                }
            } else {
                print(error)
            }
        }
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func back(sender: AnyObject) {
       performSegueWithIdentifier("eventDetailedBackSegue", sender: self) 
    }
    
    @IBAction func joinButton(sender: AnyObject) {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let username = appDelegate.userName
        let entry = PFObject(className: "Participants")
        entry.setObject(toPass, forKey: "eventId")
        entry.setObject(username, forKey: "username")
        entry.saveInBackgroundWithBlock {(success:Bool, error:NSError?) -> Void in
            
        }
        let alert = UIAlertController(title: "Joined Successful!", message: "Thanks for Joining! We hope to see you soon.", preferredStyle: UIAlertControllerStyle.Alert)
        
        // add an action (button)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
        
        // show the alert
        self.presentViewController(alert, animated: true, completion: nil)
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
