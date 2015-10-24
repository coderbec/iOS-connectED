//
//  SettingsTableViewController.swift
//  connectED
//
//  Created by Rebecca Martin on 24/10/2015.
//  Copyright © 2015 Rebecca Martin. All rights reserved.
//

import UIKit
import Parse

class SettingsTableViewController: UITableViewController,UITextFieldDelegate, UIPickerViewDataSource,UIPickerViewDelegate {
    

    @IBOutlet weak var locationPicker: UIPickerView!
   
    @IBOutlet weak var interestText: AutoCompleteTextField!

    let pickerData = ["Mozzarella","Gorgonzola","Provolone","Brie","Maytag Blue","Sharp Cheddar","Monterrey Jack","Stilton","Gouda","Goat Cheese", "Asiago"]
    
    var tags = ["new", "item", "for", "the", "tag", "table", "thing"]


    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        self.getParseTags()
        
        for tag in tags{
           // locationTagListView.addTag(tag)
        }
        
        locationPicker.dataSource = self
        locationPicker.delegate = self

    }
    
    //MARK: - Delegates and data sources
    //MARK: Data Sources
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }

    //MARK: Delegates
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //myLabel.text = pickerData[row]
    }
    
    func getParseTags(){
        var query = PFQuery(className:"TagAvail")
        query.findObjectsInBackgroundWithBlock {
            (objects, error) -> Void in
             var locations = [String]()
            if error == nil {
                // The find succeeded.
                print("Successfully retrieved \(objects!.count) scores.")
                // Do something with the found objects
                for object in objects! {
                     locations.append(object["title"]! as! String)
                }
                
              //  self.locationText.autoCompleteStrings = locations
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



    
    @IBAction func logOut(sender: AnyObject) {
        PFUser.logOut()
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        
        let nextViewController = storyBoard.instantiateViewControllerWithIdentifier("LogInVC") as! LoginViewController
        
        self.presentViewController(nextViewController, animated:true, completion:nil)
    }

    


    
}
