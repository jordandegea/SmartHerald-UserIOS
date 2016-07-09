//
//  MessageTableViewController.swift
//  SharedNews
//
//  Created by Jordan DE GEA on 16/02/2016.
//  Copyright © 2016 Jordan DE GEA. All rights reserved.
//

import UIKit
import ParseUI
import Parse

class MessageTableViewController: LocalStoredPFQueryTableViewController {
    // MARK: Properties
    
    var service:PFObject?
    var currentIndexSelected : NSIndexPath!
    
    // MARK : Outlets
    
    // MARK : Parse Main Query
    
    override func baseQuery() -> PFQuery {
        let query = PFQuery(className: "Message")
        query.whereKey("service", equalTo: (service)!)
        query.whereKey("sent", equalTo: true)
        //query.orderByAscending(MyOtherKey)
        return query
    }
    
    // MARK : View Functions
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        noDataText = "No message to display"
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objects!.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath, object: PFObject!) -> PFTableViewCell? {
        
        let cellIdentifier = "MessageTableViewCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! MessageTableViewCell
        
        cell.messageSummary.text = object["summary"] as? String
        
        return cell
    }
    
    // MARK : Transitions functions
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if  segue.identifier == "messageCellToMessage" {
            let controller = segue.destinationViewController as! MessageUIViewController
            
            //controller.transitioningDelegate = self.animatorController
            
            let cell = sender as! UITableViewCell
            let indexPath = self.tableView.indexPathForCell(cell) as NSIndexPath!
            
            self.currentIndexSelected = indexPath
            
            controller.message = self.objectAtIndexPath(indexPath)
            //controller.delegate = self
        }
    }
    
    // MARK : Others
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}
