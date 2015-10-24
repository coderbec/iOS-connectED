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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       // self.tableView.registerClass(OverviewTableViewCell.self(self), forCellReuseIdentifier: "NewCell")
    }
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        if PFUser.currentUser() != nil {
            loadData()
        }
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
                
                
                
                IJProgressView.shared.hideProgressView()
            }else{
                print("couldn't get anything")
            }
            
            self.tableView.reloadData()
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
        //let cell: OverviewTableViewCell = tableView.dequeueReusableCellWithIdentifier("NewCell", forIndexPath: indexPath) as! OverviewTableViewCell
        let cell: OverviewTableViewCell = tableView.dequeueReusableCellWithIdentifier("NewCell") as! OverviewTableViewCell
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
