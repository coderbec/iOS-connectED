//
//  EventDetailViewController.swift
//  connectED
//
//  Created by Rebecca Martin on 25/10/2015.
//  Copyright © 2015 Rebecca Martin. All rights reserved.
//

import UIKit
import Parse
import TagListView


class EventDetailViewController: UIViewController {
    
    var event: PFObject?
    
    
    @IBOutlet weak var timeImageView: UIImageView!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var hospitalLabel: UILabel!
    
    @IBOutlet weak var locationLabel: UILabel!
    
    @IBOutlet weak var categoryImageView: UIImageView!
    
    @IBOutlet weak var ownerLabel: UILabel!
    
    @IBOutlet weak var tagView: TagListView!
    
    @IBOutlet weak var blurbTextLabel: UITextView!
    
    @IBOutlet weak var quotaLabel: UILabel!
    
    
    @IBAction func reservePressed(sender: AnyObject) {
        
        //reserve
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        if event == nil{
            print("unable to get the event data")
        }else{
             print("success")
            //load the event data into the views
            
            hospitalLabel.text = event!["hospital"] as! String
            timeLabel.text = "Today 2pm"
            let duration = event!["duration"] as! Int
            timeImageView.image = UIImage(named: String(duration))
            
            let room = event!["room"] as! String
            let location = event!["location"] as! String
            
            locationLabel.text = "\(location), Room: \(room)"
            
            let category = event!["category"] as! String
            categoryImageView.image = UIImage(named: category)
            
            let owner: PFUser = event!["owner"] as! PFUser
            
            
            //get fetch stuff ehre
            do{
                try owner.fetch()
                let firstName = owner["firstName"]
                let lastName = owner["lastName"]
                
                let rank = owner["rank"]
                
                ownerLabel.text = "\(firstName) \(lastName), \(rank)"
                
            }catch{
                ownerLabel.text = "Couldn't get owner"
            }
            
            
            let tags = event!["tags"] as! [String]
            for var tag in tags {
               tagView.addTag(tag)
            }
            
            blurbTextLabel.text = event!["blurb"] as! String
            
            let taken = event!["headCount"] as! Int
            let places = event!["quota"] as! Int
            
            quotaLabel.text = "\(taken)/\(places) places left"
            
            
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
