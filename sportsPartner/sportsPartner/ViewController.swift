//
//  ViewController.swift
//  sportsPartner
//
//  Created by HeFeng on 2016-01-23.
//  Copyright © 2016 waterlooHacks. All rights reserved.
//

import UIKit
import Parse

class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    // To test Parse Functionality
    /*
    let testObject = PFObject(className: "TestObject")
    testObject["foo"] = "bar"
    testObject.saveInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
        print("Object has been saved.")
    }
    */
    let dal = DAL()
    //dal.test()
    //dal.signUp("Noxoin", password: "hello", email: "dixoncheung01@gmail.com")

        print("WEEEEEEEE")
        dal.signUp("Frank" , password: "helo" , email: "frankhanhj@gmail.com")
		
    // Do any additional setup after loading the view, typically from a nib.
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }


}

