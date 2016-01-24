//
//  CreatePostTableViewController.swift
//  sportsPartner
//
//  Created by HeFeng on 2016-01-23.
//  Copyright © 2016 waterlooHacks. All rights reserved.
//

import UIKit
import Parse

class CreatePostTableViewController: UITableViewController {

  @IBOutlet var labels: [UILabel]!
  var selectedTextField: UITextField?
  @IBOutlet var textFields: [UITextField]!
  @IBOutlet weak var textView: UITextView!
  @IBOutlet var myTableView: UITableView!
  
  var currentTextField:UITextField?
  let datePicker = UIDatePicker()
  var fromDate:NSDate?
  var toDate:NSDate?
  var eventLocation:CLLocation?
  var saveSuccessful = false
  var eventTitle:String?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    updateWidthsForLabels(labels)
    for textField in textFields {
      textField.delegate = self
    }
    textView.delegate = self
  }
  
  private func calculateLabelWidth(label: UILabel) -> CGFloat {
    let labelSize = label.sizeThatFits(CGSize(width: CGFloat.max, height: label.frame.height))
    
    return labelSize.width
  }
  
  private func calculateMaxLabelWidth(labels: [UILabel]) -> CGFloat {
    return labels.map {
      (let label) -> CGFloat in
      return calculateLabelWidth(label)
    }.maxElement()!
  }
  
  private func updateWidthsForLabels(labels: [UILabel]) {
    let maxLabelWidth = calculateMaxLabelWidth(labels)
    for label in labels {
      let constraint = NSLayoutConstraint(item: label,
        attribute: .Width,
        relatedBy: .Equal,
        toItem: nil,
        attribute: .NotAnAttribute,
        multiplier: 1,
        constant: maxLabelWidth)
      label.addConstraint(constraint)
    }
  }
  @IBAction func submit(sender: UIButton) {
    /*let testObject = PFObject(className: "Events")
    testObject["activity"] = "bar"
    testObject["description"] = "description"
    testObject["endTime"] = NSDate()
    testObject["maxParticipants"] = 4
    testObject["startTime"] = NSDate()
    testObject["title"] = "bar"
    testObject.saveInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
      print("Object has been saved.")
    }*/
    
    var invalid = false
    for textField in textFields {
      if (textField.text!.isEmpty) {
        invalid = true
        for label in labels {
          if label.tag == textField.tag {
            label.textColor = UIColor.redColor()
          }
        }
      }
      else {
        for label in labels {
          if label.tag == textField.tag {
            label.textColor = UIColor(red: 66.0/255, green: 174.0/255, blue: 221.0/255, alpha: 1.0)
          }
        }
      }
    }
    
    if(invalid) {
      return
    }
    
    
    let eventObject = PFObject(className: "Events")
    for textField in textFields {
      switch textField.tag {
      case 0:
        eventObject["title"] = textField.text
        eventTitle = textField.text
      case 1:
        eventObject["activity"] = textField.text
      case 2:
        eventObject["maxParticipants"] = Int(textField.text!)
      case 3:
        eventObject["startTime"] = fromDate
      case 4:
        eventObject["endTime"] = toDate
      default:
        print("aa")
      }
    }
    eventObject["location"] = PFGeoPoint.init(location: eventLocation)
    eventObject["description"] = textView.text
    eventObject.saveInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
      print("Object has been saved.")
      self.saveSuccessful = true;
      self.performSegueWithIdentifier("unwindToEventMapView", sender:self)
      
    }
    
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if (segue.identifier == "unwindToEventMapView") {
      let eventMapViewController = segue.destinationViewController as! EventMapViewController
      eventMapViewController.saveSuccessful = saveSuccessful
      eventMapViewController.eventTitle = eventTitle
    }
  }

  
}


extension CreatePostTableViewController: UITextFieldDelegate {
  
  func donePicker() {
    print("aa")
    if (currentTextField!.tag == 4 || currentTextField!.tag == 3) {
      let dateFormatter = NSDateFormatter()
      dateFormatter.dateStyle = .ShortStyle
      dateFormatter.timeStyle = .ShortStyle
      currentTextField?.text = dateFormatter.stringFromDate(datePicker.date)
    }
    
    currentTextField?.resignFirstResponder()
  }
  
  func canclePicker() {
    currentTextField?.text = ""
    currentTextField?.resignFirstResponder()
  }
  
  func textFieldShouldReturn(textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    return true
  }
  
  func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
    currentTextField = textField
    
      let toolBar = UIToolbar()
      toolBar.barStyle = UIBarStyle.Default
      toolBar.translucent = true
      //toolBar.tintColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
      toolBar.sizeToFit()
    
      let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.Plain, target: self, action: "donePicker")
      let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil)
      let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.Plain, target: self, action: "canclePicker")
    
      toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
      toolBar.userInteractionEnabled = true
      if (textField.tag == 4 || textField.tag == 3) {
        textField.inputView = datePicker
        if(textField.tag == 3){
          fromDate = datePicker.date
        }
        else{
          toDate = datePicker.date
        }
      }
      textField.inputAccessoryView = toolBar

    return true;
  }
}

extension CreatePostTableViewController: UITextViewDelegate {
  
  func donePicker2() {
    textView?.resignFirstResponder()
  }
  
  func canclePicker2() {
    textView?.text = ""
    textView?.resignFirstResponder()
  }
  
  func textViewShouldBeginEditing(textView: UITextView) -> Bool {
    
    let toolBar = UIToolbar()
    toolBar.barStyle = UIBarStyle.Default
    toolBar.translucent = true
    //toolBar.tintColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
    toolBar.sizeToFit()
    
    let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.Plain, target: self, action: "donePicker2")
    let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil)
    let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.Plain, target: self, action: "canclePicker2")
    
    toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
    toolBar.userInteractionEnabled = true
    
    textView.inputAccessoryView = toolBar
    return true
  }
}


