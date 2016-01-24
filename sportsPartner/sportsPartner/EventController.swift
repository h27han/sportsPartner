//
//  EventController.swift
//  sportsPartner
//
//  Created by Laetitia Huang on 2016-01-23.
//  Copyright © 2016 waterlooHacks. All rights reserved.
//

import UIKit
import Parse

class EventController: UIViewController, UITableViewDataSource, UITableViewDelegate{

    
    @IBOutlet weak var eventType: UISegmentedControl!

    
    @IBOutlet weak var tableView: EventTableView!
    
    
    var events = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
    func getActiveEvents(username:String) {
        let query = PFQuery(className: "")
        query.whereKey("userCreated", equalTo: username)
        query.orderByDescending("", less: )
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

    */
    
    func getHostedEvents(username:String) {
        let query = PFQuery(className: "")
        query.whereKey("userCreated", equalTo: username)
        query.orderByDescending("", less: )
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
    
    /*
    func getAllEvents(username:String) {
        getgetHostedEvents
        let query = PFQuery(className: "")
        query.whereKey("userCreated", equalTo: username)
        query.orderByDescending("startTime")
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
    
    */
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        var returnValue = 0
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        switch(eventType.selectedSegmentIndex)
        {
        case 0:
            //getActiveEvents(appDelegate.userName)
            returnValue = events.count
            break
            
        case 1:
            getHostedEvents(appDelegate.userName)
            returnValue = events.count
            break

        case 2:
            //getPastEvents(appDelegate.userName)
            returnValue = events.count
            break
            
        default:
            break
        }
        
        return returnValue
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let eventCell = tableView.dequeueReusableCellWithIdentifier("eventCell", forIndexPath: indexPath)
        
        switch(eventType.selectedSegmentIndex)
        {
        case 0:
            let object = events[indexPath.row]
            eventCell.row1.text = object.valueForKey("activity") as! String!
            eventCell.row2.text = event[hotelName]
            break
            
        case 1:
            /*let hotelName = hotelNames[indexPath.row]
            eventCell.nameLabel.text = hotelName
            eventCell.addressLabel.text = list2[hotelName]*/
            break
            
        case 2:
            /*
            let hotelName = hotelNames[indexPath.row]
            eventCell.nameLabel.text = hotelName
            eventCell.addressLabel.text = list3[hotelName]*/
            break
            
        default:
            break
        }

        return eventCell
    }
 
    
    @IBAction func onRefreshClicked(sender: AnyObject) {
        tableView.reloadData()
    }
    
    
    @IBAction func onSegmentChanged(sender: AnyObject) {
        tableView.reloadData()
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
