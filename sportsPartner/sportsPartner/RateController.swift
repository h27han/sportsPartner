//
//  RateController.swift
//  sportsPartner
//
//  Created by Hongjun Han on 2016-01-23.
//  Copyright © 2016 waterlooHacks. All rights reserved.
//

import UIKit
import Parse
class RateController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

	
	@IBOutlet weak var button: UIButton!
	@IBOutlet weak var label1: UILabel!
	@IBOutlet weak var label2: UILabel!
	
	@IBOutlet weak var sport1: UILabel!
	
	@IBOutlet weak var sport2: UILabel!
	
	@IBOutlet weak var sport3: UILabel!
	
	@IBOutlet weak var sport4: UILabel!
	
	@IBOutlet weak var sport5: UILabel!
	
	@IBOutlet weak var sport6: UILabel!
	
	
	@IBOutlet weak var score1: UILabel!
	
	@IBOutlet weak var score2: UILabel!
	
	@IBOutlet weak var score3: UILabel!
	
	@IBOutlet weak var score4: UILabel!
	
	@IBOutlet weak var score5: UILabel!
	
	@IBOutlet weak var score6: UILabel!
	
	
	
	@IBOutlet weak var label3: UILabel!
	@IBOutlet weak var text1: UITextField!
	@IBOutlet weak var pickerView: UIPickerView!
	@IBOutlet weak var text2: UITextField!
	@IBOutlet weak var button2: UIButton!
	@IBOutlet weak var label4: UILabel!

	
	
	
	
	var skillLevel = ["Baseball", "Basketball", "Tennis", "Badminton","Ultimate Frisbee","Soccer"];
	
	func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
		return 1
	}
 
	func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
		return skillLevel.count;
	}
 
	func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
		return skillLevel[row]
	}
	
	
	
	
	
	
    override func viewDidLoad() {
        super.viewDidLoad()

		self.pickerView.dataSource = self
		self.pickerView.delegate = self
        // Do any additional setup after loading the view.
		
		
		let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
		let aVariable = appDelegate.userName
		
		let query = PFQuery(className: "Ratings")
		query.whereKey("userReviewee", equalTo: aVariable)
		query.whereKey("Activity", equalTo: "Baseball")
		
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
					self.score1.text = String(avg)
				}
			}
		}
		
		
		let query2 = PFQuery(className: "Ratings")
		query2.whereKey("userReviewee", equalTo: aVariable)
		query2.whereKey("Activity", equalTo: "Basketball")
		
		query2.findObjectsInBackgroundWithBlock { (objects: [PFObject]?, error: NSError?) -> Void in
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
					self.score2.text = String(avg)
				}
			}
		}

		let query3 = PFQuery(className: "Ratings")
		query3.whereKey("userReviewee", equalTo: aVariable)
		query3.whereKey("Activity", equalTo: "Tennis")
		
		query3.findObjectsInBackgroundWithBlock { (objects: [PFObject]?, error: NSError?) -> Void in
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
					self.score3.text = String(avg)
				}
			}
		}
		
		let query4 = PFQuery(className: "Ratings")
		query4.whereKey("userReviewee", equalTo: aVariable)
		query4.whereKey("Activity", equalTo: "Badminton")
		
		query4.findObjectsInBackgroundWithBlock { (objects: [PFObject]?, error: NSError?) -> Void in
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
					self.score4.text = String(avg)
				}
			}
		}
		
		let query5 = PFQuery(className: "Ratings")
		query5.whereKey("userReviewee", equalTo: aVariable)
		query5.whereKey("Activity", equalTo: "Ultimate Frisbee")
		
		query5.findObjectsInBackgroundWithBlock { (objects: [PFObject]?, error: NSError?) -> Void in
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
					self.score5.text = String(avg)
				}
			}
		}
		
		let query6 = PFQuery(className: "Ratings")
		query6.whereKey("userReviewee", equalTo: aVariable)
		query6.whereKey("Activity", equalTo: "Soccer")
		
		query6.findObjectsInBackgroundWithBlock { (objects: [PFObject]?, error: NSError?) -> Void in
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
					self.score6.text = String(avg)
				}
			}
		}
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
	@IBAction func makeRate(sender: AnyObject) {
		pickerView.hidden = true
		button.hidden = true
		label1.hidden = true
		label2.hidden = true
		sport1.hidden = true
		sport2.hidden = true
		sport3.hidden = true
		sport4.hidden = true
		sport5.hidden = true
		sport6.hidden = true
		score1.hidden = true
		score2.hidden = true
		score3.hidden = true
		score4.hidden = true
		score5.hidden = true
		score6.hidden = true
		
		
		
		
		
		label4.hidden = false
		label3.hidden = false
		text1.hidden = false
		pickerView.hidden = false
		text2.hidden = false
		button2.hidden = false
	}
    
	@IBAction func goBack(sender: AnyObject) {
		let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
		let aVariable = appDelegate.userName
		
		
		let reviewer = aVariable
		let reviewee = text1.text ?? ""
		let activityName = pickerView(pickerView, titleForRow: pickerView.selectedRowInComponent(0), forComponent: 2)
		let rating = text2.text ?? ""
		print (activityName)
		let intRating: Int? = Int(rating)

		
		
		let entry = PFObject(className: "Ratings")
		entry.setObject(reviewer, forKey: "userReviewer")
		entry.setObject(reviewee, forKey: "userReviewee")
		entry.setObject(activityName , forKey: "Activity")
		entry.setObject(intRating ?? 0, forKey: "Rating")
		entry.saveInBackgroundWithBlock {(success:Bool, error:NSError?) -> Void in
			
		}
		
		
		let alert = UIAlertController(title: "Rate Successful!", message: "Press ok to continue", preferredStyle: UIAlertControllerStyle.Alert)
		
		// add an action (button)
		alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
		
		// show the alert
		self.presentViewController(alert, animated: true, completion: nil)
		
		
		pickerView.hidden = false
		button.hidden = false
		label1.hidden = false
		label2.hidden = false
		sport1.hidden = false
		sport2.hidden = false
		sport3.hidden = false
		sport4.hidden = false
		sport5.hidden = false
		sport6.hidden = false
		score1.hidden = false
		score2.hidden = false
		score3.hidden = false
		score4.hidden = false
		score5.hidden = false
		score6.hidden = false
		
		
		label4.hidden = true
		label3.hidden = true
		text1.hidden = true
		pickerView.hidden = true
		text2.hidden = true
		button2.hidden = true
		
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
