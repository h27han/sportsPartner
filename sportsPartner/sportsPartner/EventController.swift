//
//  EventController.swift
//  sportsPartner
//
//  Created by Laetitia Huang on 2016-01-23.
//  Copyright © 2016 waterlooHacks. All rights reserved.
//

import UIKit
import Foundation
import Parse

class EventController: UIViewController, UITableViewDataSource, UITableViewDelegate{

    
    @IBOutlet weak var eventType: UISegmentedControl!

    
    @IBOutlet weak var tableView: EventTableView!
    
    
    var event0 = []
    var event1 = []
    var event2 = []
    var ini = false
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        
        
        // initialization

        tableView.delegate = self
        tableView.dataSource = self
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        getActiveEvents(appDelegate.userName)
        getHostedEvents(appDelegate.userName)
        getPastEvents(appDelegate.userName)
        tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func getActiveEvents(username:String) {
        var resArray: [PFObject] = []
        let query1 = PFQuery(className: "Events")
        query1.whereKey("userCreated", equalTo: username)
        query1.orderByDescending("endTime")
        query1.findObjectsInBackgroundWithBlock { (objects1: [PFObject]?, error: NSError?) -> Void in
            if error == nil {
                //if let objects1 = objects1 {
                    let query2 = PFQuery(className: "Participates")
                    query2.whereKey("username", equalTo: username)
                    query2.orderByDescending("endTime")
                    query2.findObjectsInBackgroundWithBlock { (objects2: [PFObject]?, error: NSError?) -> Void in
                        if error == nil {
                            var x = 0
                            var y = 0

                            //if let objects2 = objects2 {
                                for _ in 0..<(objects1!.count + objects2!.count) {
                                    if(x == objects1!.count) {
                                        resArray.append(objects2![y])
                                        y++;
                                    } else if (y == objects2!.count) {
                                        resArray.append(objects1![x])
                                        x++;
                                    } else {
                                        let a = objects1![x]
                                        let b = objects2![y]
                                        if((a["endTime"] as! NSDate).compare(b["endTime"] as! NSDate) == NSComparisonResult.OrderedDescending) {
                                            resArray.append(a)
                                            x++;
                                        } else {
                                            resArray.append(b)
                                            y++;
                                        }
                                    }
                                }
                                //resArray is ready
                                self.event0 = resArray
                                if !(self.ini) {
                                    self.tableView.reloadData()
                                    self.ini = true
                                    
                                }
                            //}
                        } else {
                            print(error)
                        }
                //    }
                }
            } else {
                print(error)
            }
        }
    }

    
    
    func getHostedEvents(username:String) {
        let query = PFQuery(className: "Events")
        query.whereKey("userCreated", equalTo: username)
        query.orderByDescending("endTime")
        query.findObjectsInBackgroundWithBlock { (objects: [PFObject]?, error: NSError?) -> Void in
            if error == nil {
                if let objects = objects {
                    self.event1 = objects
                }
            } else {
                print(error)
            }
        }
    }
    
    
    func getPastEvents(username:String) {
        var resArray: [PFObject] = []
        let query1 = PFQuery(className: "Events")
        query1.whereKey("userCreated", equalTo: username)
        query1.orderByDescending("endTime")
        query1.findObjectsInBackgroundWithBlock { (objects1: [PFObject]?, error: NSError?) -> Void in
            if error == nil {
                //if let objects1 = objects1 {
                let query2 = PFQuery(className: "Participates")
                query2.whereKey("username", equalTo: username)
                query2.orderByDescending("endTime")
                query2.findObjectsInBackgroundWithBlock { (objects2: [PFObject]?, error: NSError?) -> Void in
                    if error == nil {
                        var x = 0
                        var y = 0
                        //if let objects2 = objects2 {
                        for _ in 0..<(objects1!.count + objects2!.count) {
                            if(x == objects1!.count) {
                                resArray.append(objects2![y])
                                y++;
                            } else if (y == objects2!.count) {
                                resArray.append(objects1![x])
                                x++;
                            } else {
                                let a = objects1![x]
                                let b = objects2![y]
                                if((a["endTime"] as! NSDate).compare(b["endTime"] as! NSDate) == NSComparisonResult.OrderedDescending) {
                                    resArray.append(a)
                                    x++;
                                } else {
                                    resArray.append(b)
                                    y++;
                                }
                            }
                        }
                        //resArray is ready
                        self.event2 = resArray
                        //}
                    } else {
                        print(error)
                    }
                    //    }
                }
            } else {
                print(error)
            }
        }
    }
    
    
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        var returnValue = 0
        
        switch(eventType.selectedSegmentIndex)
        {
        case 0:
            getActiveEvents(appDelegate.userName)
            returnValue = event0.count
            break
            
        case 1:
            getHostedEvents(appDelegate.userName)
            returnValue = event1.count
            break

        case 2:
            getPastEvents(appDelegate.userName)
            returnValue = event2.count
            break
            
        default:
            break
        }
        return returnValue
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let eventCell = tableView.dequeueReusableCellWithIdentifier("eventCell", forIndexPath: indexPath) as!  dynamicCell
        
        var activity = "", title = "", maxParticipants = 0, description = ""
        
        switch(eventType.selectedSegmentIndex)
        {
        case 0:
            let object = event0[indexPath.row]
            activity = object["activity"] as! String
            title = object["title"] as! String
            maxParticipants = object["maxParticipants"] as! Int
            description = object["description"] as! String
            eventCell.row1.text = activity.isEmpty ? title : activity + "-" + title
            eventCell.row2.text = maxParticipants == 0 ? description : "\(maxParticipants) people maximum \(description)"
            break
            
        case 1:
            
            let object = event1[indexPath.row]
            activity = object["activity"] as! String
            title = object["title"] as! String
            maxParticipants = object["maxParticipants"] as! Int
            description = object["description"] as! String
            eventCell.row1.text = activity.isEmpty ? title : activity + "-" + title
            eventCell.row2.text = maxParticipants == 0 ? description : "\(maxParticipants) people maximum \(description)"
            
            break
            
        case 2:
            let object = event2[indexPath.row]
            activity = object["activity"] as! String
            title = object["title"] as! String
            maxParticipants = object["maxParticipants"] as! Int
            description = object["description"] as! String
            eventCell.row1.text = activity.isEmpty ? title : activity + "-" + title
            eventCell.row2.text = maxParticipants == 0 ? description : "\(maxParticipants) people maximum \(description)"
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
