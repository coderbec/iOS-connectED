//
//  OverviewTableViewController.swift
//  connectED
//
//  Created by Rebecca Martin on 24/10/2015.
//  Copyright © 2015 Rebecca Martin. All rights reserved.
//

import UIKit
import Parse
import TagListView

class OverviewTableViewController: UITableViewController {
    

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
        return events.count
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        return 1
        
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 140
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell:OverviewTableViewCell = tableView.dequeueReusableCellWithIdentifier("Cell") as! OverviewTableViewCell
       // let cell:OverviewTableViewCell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! OverviewTableViewCell
        
        let owner: PFUser = events[indexPath.row]["owner"] as! PFUser
        
        var blurb = events[indexPath.row]["blurb"] as! String
        var ownerName = owner.username
        cell.blurbLabel.text = "\(ownerName)   \(blurb)"
        let headCount = events[indexPath.row]["headCount"] as! Int
        let quota = events[indexPath.row]["quota"] as! Int
        
        let ratio = ("\(headCount)/\(quota)")
        cell.quotaLabel.text = ratio
        
        let tags = events[indexPath.row]["tags"] as! [String]
        for tag in tags{
            cell.tagViewLabel.addTag(tag)
        }
        
        let duration = String(events[indexPath.row]["duration"] as! Int)
        cell.timeLabel.text = duration
        
       
        
        return cell
    }
    


}
