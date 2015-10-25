//
//  NewEventViewController.swift
//  connectED
//
//  Created by Rebecca Martin on 25/10/2015.
//  Copyright © 2015 Rebecca Martin. All rights reserved.
//

import UIKit
import DKDropMenu
import Parse
import IQDropDownTextField

class NewEventViewController: UIViewController, DKDropMenuDelegate, KSTokenViewDelegate{
    
    var names: Array<String> = []
    @IBOutlet weak var categoryDropDown: UITextField!
    var categoryPicker = UIPickerView()
    
    @IBOutlet weak var dateDropDown: UITextField!
    
    var datePicker = UIPickerView()
    
    @IBOutlet weak var timeDropDown: UITextField!
    
    var timePicker = UIPickerView()
    
    @IBOutlet weak var durationDropDown: UITextField!
    
    var durationPicker = UIPickerView()
    
    @IBOutlet weak var locationDropDown: UITextField!
    var locationPicker = UIPickerView()
    
//text fields
    @IBOutlet weak var locationField: UITextField!
    
    @IBOutlet weak var roomField: UITextField!
    
    @IBOutlet weak var blurbView: UITextView!
    
    @IBOutlet weak var placesField: UITextField!
    
    @IBOutlet var tokenView: KSTokenView!
    
    var time = ["", ""]
    
    var categories = ["Prescription", "Management", "Research", "Lecture", "Investigation", "Patient", "Drugs", "Assessment"]
    
    var dates = ["Now", "Later"]
    
    var durations = ["15mins", "30mins", "45mins", "60min+"]
    
    var locations = ["1", "3", "2", "Lecture", "4", "5", "6", "Assessment"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

       categoryDropDown.text = "Patient"
        dateDropDown.text = "Now"
        timeDropDown.text = "Now"
        durationDropDown.text = "45"
        locationDropDown.text = ""
        locationField.text = "Ward 1B"
        roomField.text = "78"
        
        
        
        tokenView.delegate = self
        tokenView.promptText = "Add tags: "
        tokenView.placeholder = "Type to search"
        tokenView.descriptionText = "Available tags"
        //tokenView.addToken
        tokenView.maxTokenLimit = 5 //default is -1 for unlimited number of tokens
        tokenView.style = .Rounded
        //tokenView.addToken("carniconoma")
        loadTokens()
        
        blurbView.text = "this is stage five, patient revieving treatment"
        
        placesField.text = "5"
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
//    
//    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
//        
//        if pickerView == locationPicker{
//            return locations.count
//        }else if pickerView == durationPicker{
//            return durations.count
//        }else if pickerView == timePicker{
//            return time.count
//        }else if pickerView == datePicker{
//            return dates.count
//        }else if pickerView == categoryPicker{
//            return categories.count
//        }else {
//            return 0
//        }
//    }
//    
//    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
//        if pickerView.isEqual(locationPicker){
//            return locations[row]
//        }else if pickerView.isEqual(durationPicker){
//            return durations[row]
//        }else if pickerView.isEqual(timePicker){
//            return time[row]
//        }else if pickerView.isEqual(datePicker){
//            return dates[row]
//        }else if pickerView.isEqual(categoryPicker){
//            return categories[row]
//        }else {
//            return ""
//        }
//    }
    
//    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//        
//        if pickerView.isEqual(locationPicker){
//            locationDropDown.text = locations[row]
//        }else if pickerView.isEqual(durationPicker){
//            durationDropDown.text = durations[row]
//        }else if pickerView.isEqual(timePicker){
//            timeDropDown.text = time[row]
//        }else if pickerView.isEqual(datePicker){
//            dateDropDown.text = dates[row]
//        }else if pickerView.isEqual(categoryPicker){
//            categoryDropDown.text = categories[row]
//        }else {
//            print("error")
//        }
//
  //  }
    
    func loadTokens(){
        var query = PFQuery(className:"TagAvail")
        query.findObjectsInBackgroundWithBlock {
            (objects, error) -> Void in
            
            if error == nil {
                // The find succeeded.
                print("Successfully retrieved \(objects!.count) scores.")
                // Do something with the found objects
                if let objects = objects  {
                    for object in objects {
                        self.names.append(object["title"] as! (String))
                    }
                }
            } else {
                // Log details of the failure
                print("Error: \(error!)")
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func submitEvent(sender: AnyObject) {
        
        IJProgressView.shared.showProgressView(view)

        var event = PFObject(className:"Event")
        event["blurb"] = blurbView.text as String
        event["duration"] = 60
        event["head_count"] = Int(placesField.text!)
        event["hospital"] = "Cabrini Hospital"
        event["location"] = "Lecture Theatre"
        event["owner"] = PFUser.currentUser()
        event["quota"] = 5
        event["start_time"] = NSDate()

        event["tags"] = ["chest", "wound", "drugs"]
        
        event.saveInBackgroundWithBlock {
            (success: Bool, error: NSError?) -> Void in
            if (success) {
                // The object has been saved.
                IJProgressView.shared.hideProgressView()
            } else {
                // There was a problem, check error.description
            }
        }

     
    }
    
    
    func itemSelectedWithIndex(index: Int, name: String) {
        print("\(name) selected");
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func tokenView(token: KSTokenView, performSearchWithString string: String, completion: ((results: Array<AnyObject>) -> Void)?) {
        var data: Array<String> = []
        for value: String in names {
            if value.lowercaseString.rangeOfString(string.lowercaseString) != nil {
                data.append(value)
            }
        }
        completion!(results: data)
    }
    
    func tokenView(token: KSTokenView, displayTitleForObject object: AnyObject) -> String {
        return object as! String
    }

}
