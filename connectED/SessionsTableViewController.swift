//
//  SessionsTableViewController.swift
//  connectED
//
//  Created by Rebecca Martin on 24/10/2015.
//  Copyright © 2015 Rebecca Martin. All rights reserved.
//

import UIKit
import Parse

class SessionsTableViewController: UITableViewController {

    var events = [PFObject]()
    
    //
    //    override func awakeFromNib() {
    //        super.awakeFromNib()
    //
    //    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        if PFUser.currentUser() != nil {
            loadData()
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
    
    
    
    func loadData(){
        
        IJProgressView.shared.showProgressView(view)
        events = [PFObject]()
        
        
        self.tableView.reloadData()
        
        //  let pred = NSPredicate(format: "user1 = %@ OR user2 = %@", PFUser.currentUser(), PFUser.currentUser())
        
        let eventQuery = PFQuery(className: "Event")
        eventQuery.orderByDescending("lastUpdate")
        eventQuery.includeKey("owner")
        
        
        
        eventQuery.findObjectsInBackgroundWithBlock { (results, error) -> Void in
            if error == nil {
                
                self.events = results!
                print(self.events)
                
                self.tableView.reloadData()
                
                IJProgressView.shared.hideProgressView()
            }else{
                print("couldn't get anything")
            }
            
            
        }
        
        
    }
    
    // MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            if let destination = segue.destinationViewController as? EventDetailViewController{
                if let blogIndex = tableView.indexPathForSelectedRow?.row {
                    destination.event = events[blogIndex]
                }
            }
        }
    }
    
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // Return the number of sections.
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        return events.count
        
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 140
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell:SessionsTableViewCell = tableView.dequeueReusableCellWithIdentifier("Cell") as! SessionsTableViewCell
        // let cell:OverviewTableViewCell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! OverviewTableViewCell
        
        let owner: PFUser = events[indexPath.row]["owner"] as! PFUser
        var ownerfirstName = owner["firstName"]
        var ownerLastName = owner["lastName"]
        
        //text
        
        cell.hospitalLabel.text = events[indexPath.row]["hospital"] as! String
        cell.doctorLabel.text = "\(ownerfirstName) \(ownerLastName)"
        cell.timeLabel.text = "Today 2pm"
        
        //quota
        let headCount = events[indexPath.row]["headCount"] as! Int
        let quota = events[indexPath.row]["quota"] as! Int
        
        let ratio = ("\(headCount)/\(quota)")
        cell.quotaLabel.text = ratio
        
        //tags
        cell.tagViewLabel.removeAllTags()
        let tags = events[indexPath.row]["tags"] as! [String]
        for tag in tags{
            cell.tagViewLabel.addTag(tag)
        }
        
        //images
        let duration = String(events[indexPath.row]["duration"] as! Int)
        cell.timeImage.image = UIImage(named: duration)
        
        //icons
        let category = events[indexPath.row]["category"] as! String
        cell.categoryImage.image = UIImage(named: category)
        
        return cell
        
    }
    

    

}
