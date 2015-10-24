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


class LoginViewController: PFLogInViewController, PFLogInViewControllerDelegate, PFSignUpViewControllerDelegate  {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.delegate = self
        //self.signUpController.delegate = self
        
        self.logInView!.logo = UIImageView(image: UIImage(named: "logo"))
        
        self.logInView!.logo!.contentMode = .Center
        
        //self.signUpController.signUpView.logo.contentMode = UIViewContentMode.Center
        
        self.logInView!.signUpButton!.removeTarget(self, action: nil, forControlEvents: .AllEvents)
        
        //self.logInView!.signUpButton!.addTarget(self, action: "displaySignUp", forControlEvents: .TouchUpInside)
        
        self.logInView!.signUpButton!.addTarget(self, action: "buttonPressed:", forControlEvents: .TouchUpInside)
        
        if PFUser.currentUser() != nil {
            showOverview()
        }

    }

    
    func logInViewController(logInController: PFLogInViewController!, didLogInUser user: PFUser!) {
        
        let installation = PFInstallation.currentInstallation()
        installation["user"] = PFUser.currentUser()
        installation.saveInBackgroundWithBlock(nil)
        
        showOverview()
    }
    
    
    
    /*func signUpViewController(signUpController: PFSignUpViewController!, didSignUpUser user: PFUser!) {
    signUpController.dismissViewControllerAnimated(true, completion: { () -> Void in
    let installation = PFInstallation.currentInstallation()
    installation["user"] = PFUser.currentUser()
    installation.saveInBackgroundWithBlock(nil)
    self.showChatOverview()
    })
    }*/
    
    
    func showOverview() {
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        
        let overviewVC = sb.instantiateViewControllerWithIdentifier("FirstVC") as! EntryViewController
        
        overviewVC.navigationItem.setHidesBackButton(true, animated: false)
        
        self.navigationController!.pushViewController(overviewVC, animated: true)
        
    }
    
    func buttonPressed(sender: UIButton!) {
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        
        let signUpVC = sb.instantiateViewControllerWithIdentifier("SignUpVC") as! SignUpTableViewController
        
        
        self.performSegueWithIdentifier("signUp", sender: self)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}
