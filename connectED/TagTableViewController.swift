//
//  TagTableViewController.swift
//  connectED
//
//  Created by Rebecca Martin on 24/10/2015.
//  Copyright © 2015 Rebecca Martin. All rights reserved.
//

import UIKit
import Parse
import ParseUI

protocol TagTableViewControllerDelegate
{
    func addTag(var strText : NSString)
}

class TagTableViewController: PFQueryTableViewController, UISearchBarDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    
    var searchString = ""
    var searchInProgress = false
    var delegate : TagTableViewControllerDelegate?
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        
        
        
        self.parseClassName = "TagAvail"
        self.pullToRefreshEnabled = true
        self.paginationEnabled = true
        self.objectsPerPage = 25
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        
    }
    
    
    override func queryForTable() -> PFQuery {
        let query = PFQuery(className: "TagAvail")

        if searchInProgress {
            query.whereKey("title", containsString: searchString)
        }
        
//        if self.objects!.count == 0 {
//            query!.cachePolicy = PFCachePolicy.CacheThenNetwork
//        }
        
        query.orderByAscending("title")
        
        return query
        
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        searchString = searchText
        searchInProgress = true
        self.loadObjects()
        searchInProgress = false
    }
    

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

 


}
