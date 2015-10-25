//
//  SignUpTableViewController.swift
//  connectED
//
//  Created by Rebecca Martin on 24/10/2015.
//  Copyright © 2015 Rebecca Martin. All rights reserved.
//

import UIKit
import Parse
import ParseUI
import DKDropMenu

class SignUpTableViewController: UIViewController, DKDropMenuDelegate {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var emailDropDown: DKDropMenu!
    
    @IBOutlet weak var passwordTextField: UITextField!

    @IBOutlet weak var specialtyField: UITextField!
    @IBOutlet weak var rankField: UITextField!
    @IBOutlet weak var firstNameField: UITextField!
    @IBOutlet weak var lastNameField: UITextField!
    
    var email: String?
    
    var change = false

    override func viewDidLoad() {
        super.viewDidLoad()


        
        //set up the drop menu
        
        getDropDown()
        
        emailDropDown.delegate = self
        


    }
    
    func itemSelectedWithIndex(index: Int, name: String) {
        print("\(name) selected");
        email = name
    }

    func getDropDown(){
        var query = PFQuery(className:"HospitalAvail")
        query.findObjectsInBackgroundWithBlock {
            (objects, error) -> Void in
            
            if error == nil {
                // The find succeeded.
                print("Successfully retrieved \(objects!.count) scores.")
                // Do something with the found objects
                for object in objects! {
                self.emailDropDown.addItems(object["allowedEmails"] as! [String])
                       
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


    @IBAction func cancelButton(sender: AnyObject) {
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func completeSignUp(sender: AnyObject) {
  
        
        if emailTextField.text != "" && passwordTextField.text != "" && firstNameField.text != "" && lastNameField.text != "" {
            
            var user = PFUser()
            
            user.email = emailTextField.text
            user.username = emailTextField.text! + email!
            user["firstName"] = firstNameField.text
            user["lastName"] = lastNameField.text
            user["rank"] = rankField.text
            user["specialty"] = specialtyField.text
            
            
            user.signUpInBackgroundWithBlock({ (success, error) -> Void in
                if error == nil {
                    let installation = PFInstallation.currentInstallation()
                    installation["user"] = user
                    installation.saveInBackgroundWithBlock(nil)
                    
                    self.showOverview()
                }
            })
            
            
            
        }else{
            let alert = UIAlertController(title: "Missing information", message: "Please fill out all items", preferredStyle: UIAlertControllerStyle.Alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            
            self.presentViewController(alert, animated: true, completion: nil)
            
            
        }
        
        
    }
    
    
    func showOverview() {
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        
        let overviewVC = EntryViewController()
        
        let nc = UINavigationController()
        nc.setNavigationBarHidden(true, animated: false)
        //overviewVC.navigationItem.setHidesBackButton(true, animated: false)
        
        nc.pushViewController(overviewVC, animated: true)
        
    }
    


}
