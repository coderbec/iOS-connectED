//
//  LoginViewController.swift
//  connectED
//
//  Created by Rebecca Martin on 24/10/2015.
//  Copyright © 2015 Rebecca Martin. All rights reserved.
//

import UIKit
import Parse
import Bolts
import ParseUI
import SwiftValidator


class LoginViewController: ViewController  {
    
    
    @IBOutlet weak var username: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

      
        if PFUser.currentUser() != nil {
            showOverview()
        }

    }


    
    @IBAction func signIn(sender: AnyObject) {
        if username.text != nil && passwordField.text != nil{
            login(username.text!, password: passwordField.text!)
        }
    }
    
    func login(username: String, password: String){
        PFUser.logInWithUsernameInBackground(username, password:password) {
            (user: PFUser?, error: NSError?) -> Void in
            if user != nil {
                // Do stuff after successful login.
                self.showOverview()
            } else {
                // The login failed. Check error to see why.
            }
        }
    }
    
    func showOverview() {
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        
        let overviewVC = sb.instantiateViewControllerWithIdentifier("FirstVC") as! EntryViewController
        
        overviewVC.navigationItem.setHidesBackButton(true, animated: false)
        
        self.navigationController!.pushViewController(overviewVC, animated: true)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}
