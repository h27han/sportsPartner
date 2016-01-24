//
//  EventController.swift
//  sportsPartner
//
//  Created by Laetitia Huang on 2016-01-23.
//  Copyright © 2016 waterlooHacks. All rights reserved.
//

import UIKit

class EventController: UIViewController, UITableViewDataSource, UITableViewDelegate{

    
    @IBOutlet weak var eventType: UISegmentedControl!

    
    @IBOutlet weak var tableView: EventTableView!
    
    let list1:[String] = ["la","la"]
    let list2:[String] = ["1","2", "3"]
    let list3:[String] = ["1","2", "3", "4"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        var returnValue = 0
        
        switch(eventType.selectedSegmentIndex)
        {
        case 0:
            returnValue = list1.count
            break
            
        case 1:
            returnValue = list2.count
            break

        case 2:
            returnValue = list3.count
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
            eventCell.textLabel!.text = list1[indexPath.row]
            break
            
        case 1:
            eventCell.textLabel!.text = list2[indexPath.row]
            break
            
        case 2:
            eventCell.textLabel!.text = list3[indexPath.row]
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
