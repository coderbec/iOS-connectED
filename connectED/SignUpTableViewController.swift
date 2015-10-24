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

class SignUpTableViewController: UITableViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var repeatPasswordTextField: UITextField!
    @IBOutlet weak var specialtyField: UITextField!
    @IBOutlet weak var rankField: UITextField!
    @IBOutlet weak var firstNameField: UITextField!
    @IBOutlet weak var lastNameField: UITextField!
    
    @IBOutlet weak var doneBarButtonItem: UIBarButtonItem!

    
    
    var change = false

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.rightBarButtonItem = doneBarButtonItem
        
        if change {
            doneBarButtonItem.action = "changeProfile"
            
            emailTextField.text = PFUser.currentUser()!.email
            firstNameField.text = PFUser.currentUser()!["firstName"] as! String
            lastNameField.text = PFUser.currentUser()!["lastName"] as! String
            
            passwordTextField.enabled = false
            repeatPasswordTextField.enabled = false
            
            rankField.text = PFUser.currentUser()!["rank"] as! String
            specialtyField.text = PFUser.currentUser()!["specialty"] as! String
            
            
            
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
  
        
        if emailTextField.text != "" && passwordTextField.text != "" && repeatPasswordTextField.text != "" && firstNameField.text != "" && lastNameField.text != "" {
            
            var user = PFUser()
            
            
            user.email = emailTextField.text
            user.username = emailTextField.text
            
            
            if passwordTextField.text == repeatPasswordTextField.text {
                user.password = passwordTextField.text
            }else{
                let alert = UIAlertController(title: "Check your password", message: "Your entered passwords are not the same", preferredStyle: UIAlertControllerStyle.Alert)
                
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
                
                self.presentViewController(alert, animated: true, completion: nil)
                
            }
            
            
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

    func changeProfile () {
        
        if emailTextField.text != ""  && firstNameField.text != "" && lastNameField.text != "" {
            

            PFUser.currentUser()!.email = emailTextField.text
            
            
            PFUser.currentUser()!["firstName"] = firstNameField.text
            PFUser.currentUser()!["lastName"] = lastNameField.text
            PFUser.currentUser()!.saveInBackgroundWithBlock({ (success, error) -> Void in
                if error == nil {
                    self.navigationController?.popViewControllerAnimated(true)
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
