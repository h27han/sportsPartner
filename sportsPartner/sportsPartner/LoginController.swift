//
//  LoginController.swift
//  sportsPartner
//
//  Created by Hongjun Han on 2016-01-23.
//  Copyright © 2016 waterlooHacks. All rights reserved.
//
import Parse
import UIKit

class LoginController: UIViewController {

	@IBOutlet weak var account: UITextField!
	@IBOutlet weak var password: UITextField!
	let dal = DAL();
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
	@IBAction func login(sender: AnyObject) {
	
		let Useraccount = account.text ?? ""
		let Userpassword = password.text ?? ""
		
		
		PFUser.logInWithUsernameInBackground(Useraccount, password: Userpassword) { user, error in
			if user != nil {
				//self.performSegueWithIdentifier(self.scrollViewWallSegue, sender: nil)
				self.performSegueWithIdentifier("MainApp", sender: self)
				
			} else if let error = error {
				//self.showErrorView(error)
				let alert = UIAlertController(title: "Warning", message: "Login Failed", preferredStyle: UIAlertControllerStyle.Alert)
				
				// add an action (button)
				alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
				
				// show the alert
				self.presentViewController(alert, animated: true, completion: nil)
			}
			
			
		}
	
		
	}

	@IBAction func register(sender: AnyObject) {
		performSegueWithIdentifier("Register", sender: self)
		
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
