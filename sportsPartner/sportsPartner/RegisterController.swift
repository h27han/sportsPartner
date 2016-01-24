//
//  RegisterController.swift
//  sportsPartner
//
//  Created by Hongjun Han on 2016-01-23.
//  Copyright © 2016 waterlooHacks. All rights reserved.
//

import UIKit
import Parse
class RegisterController: UIViewController {

	@IBOutlet weak var email: UITextField!
	@IBOutlet weak var password: UITextField!
	@IBOutlet weak var account: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
	@IBAction func back(sender: AnyObject) {
		performSegueWithIdentifier("Login", sender: self)
	}
	@IBAction func register(sender: AnyObject) {
		
		let Useraccount = account.text ?? ""
		let Userpassword = password.text ?? ""
		let Useremail = email.text ?? ""
	
		let user = PFUser()
		
		//2
		user.username = Useraccount
		user.password = Userpassword
		user.email = Useremail
		
		//3
		user.signUpInBackgroundWithBlock { succeeded, error in
			if (succeeded) {
				//The registration was successful, go to the wall
				//self.performSegueWithIdentifier(self.scrollViewWallSegue, sender: nil)
				
				print("Sign Up Successful")
				
				
				let alert = UIAlertController(title: "Register Successful!", message: "Back to login", preferredStyle: UIAlertControllerStyle.Alert)
				
				// add an action (button)
				alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
				
				// show the alert
				self.presentViewController(alert, animated: true, completion: nil)
				
				
			} else if let error = error {
				//Something bad has occurred
				//self.showErrorView(error)
				
				let alert = UIAlertController(title: "Register failed!", message: "Retry", preferredStyle: UIAlertControllerStyle.Alert)
				
				// add an action (button)
				alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
				
				// show the alert
				self.presentViewController(alert, animated: true, completion: nil)

				print("Sign Up Failed")
				
			}
		}
		
		
		

		
		

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
