//
//  ProfileController.swift
//  sportsPartner
//
//  Created by Hongjun Han on 2016-01-23.
//  Copyright © 2016 waterlooHacks. All rights reserved.
//

import UIKit
import Parse

class ProfileController: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIPickerViewDataSource, UIPickerViewDelegate{

	@IBOutlet weak var userNameLabel: UILabel!
	@IBOutlet weak var switchOn: UISwitch!
	@IBOutlet weak var photo: UIImageView!
	@IBOutlet weak var userName: UILabel!
	var imagePicker = UIImagePickerController()
	
	    var pickerDataSource = ["Baseball", "Basketball", "Tennis", "Badminton","Ultimate Frisbee","Soccer"];

	
	@IBOutlet weak var changePhoto: UIButton!
	
	@IBAction func changePhoto(sender: AnyObject) {
		imagePicker.allowsEditing = false
		imagePicker.sourceType = .PhotoLibrary
		
		presentViewController(imagePicker, animated: true, completion: nil)
		
		
	}
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
		
		imagePicker.delegate = self
		
		self.picker.dataSource = self
		self.picker.delegate = self
		
		let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
		let aVariable = appDelegate.userName
		userNameLabel.text = aVariable
		
		
    }

	func imagePickerControllerDidCancel(picker: UIImagePickerController) {
		dismissViewControllerAnimated(true, completion: nil)
	}
	

	
	
	@IBOutlet weak var picker: UIPickerView!
	
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
	func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
		return 1
	}
 
	func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
		return pickerDataSource.count;
	}
 
	func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
		return pickerDataSource[row]
	}
	
	@IBAction func triggerChange(sender: AnyObject) {
		
		
		var localNotification = UILocalNotification()
		localNotification.fireDate = NSDate(timeIntervalSinceNow: 5)
		localNotification.alertBody = "You have a new event"
		localNotification.timeZone = NSTimeZone.defaultTimeZone()
		localNotification.applicationIconBadgeNumber = UIApplication.sharedApplication().applicationIconBadgeNumber + 1
		
		UIApplication.sharedApplication().scheduleLocalNotification(localNotification)
		
		print("gg")
		if (switchOn.selected){
			
		}
	}
	

	@IBAction func changePassword(sender: AnyObject) {
		var loginTextField: UITextField?
		let alertController = UIAlertController(title: "Reset Password", message: "Input your register email", preferredStyle: .Alert)
		let ok = UIAlertAction(title: "OK", style: .Default, handler: { (action) -> Void in
			do{
				try PFUser.requestPasswordResetForEmail(loginTextField?.text ?? "")
				
					let alert = UIAlertController(title: "Email Sent!", message: "Check your email for the resetting link", preferredStyle: UIAlertControllerStyle.Alert)
				
					// add an action (button)
					alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
				
					// show the alert
					self.presentViewController(alert, animated: true, completion: nil)

				
			} catch{
				
			}

		})
		let cancel = UIAlertAction(title: "Cancel", style: .Cancel) { (action) -> Void in
		}
		alertController.addAction(ok)
		alertController.addAction(cancel)
		alertController.addTextFieldWithConfigurationHandler { (textField) -> Void in
			// Enter the textfiled customization code here.
			loginTextField = textField
			loginTextField?.placeholder = "Enter your email"
		}
		presentViewController(alertController, animated: true, completion: nil)
		
		
		
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
