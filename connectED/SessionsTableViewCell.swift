//
//  SessionsTableViewCell.swift
//  connectED
//
//  Created by Rebecca Martin on 25/10/2015.
//  Copyright © 2015 Rebecca Martin. All rights reserved.
//

import UIKit
import TagListView



class SessionsTableViewCell: UITableViewCell {

    @IBOutlet weak var quotaLabel: UILabel!
    
    @IBOutlet weak var tagViewLabel: TagListView!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var timeImage: UIImageView!
    
    @IBOutlet weak var hospitalLabel: UILabel!
    
    
    @IBOutlet weak var doctorLabel: UILabel!
    
    @IBOutlet weak var categoryImage: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

}
