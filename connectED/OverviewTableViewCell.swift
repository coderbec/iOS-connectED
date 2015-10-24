
//
//  OverviewTableViewCell.swift
//  connectED
//
//  Created by Rebecca Martin on 24/10/2015.
//  Copyright © 2015 Rebecca Martin. All rights reserved.
//

import UIKit
import TagListView

class OverviewTableViewCell: UITableViewCell {
    
    @IBOutlet weak var blurbLabel: UILabel!
    
    @IBOutlet weak var quotaLabel: UILabel!

    @IBOutlet weak var tagViewLabel: TagListView!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
