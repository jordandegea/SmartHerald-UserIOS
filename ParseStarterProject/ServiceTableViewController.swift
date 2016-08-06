//
//  ServiceTableViewController.swift
//  Smart Herald
//
//  Created by Jordan DE GEA on 22/02/2016.
//  Copyright © 2016 Jordan DE GEA. All rights reserved.
//

import UIKit
import Parse
import ParseUI
import CoreData

extension UIImage {
    static func fromColor(color: UIColor) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        CGContextSetFillColorWithColor(context, color.CGColor)
        CGContextFillRect(context, rect)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img
    }
}

class ServiceTableViewController: LocalStoredPFQueryTableViewController{

    // MARK: Properties
    
    var currentIndexSelected : NSIndexPath!
    
    
    // MARK : Parse Main Query
    
    override func baseQuery() -> PFQuery {
        
        let query = PFQuery(className: "Subscription")
        if ( PFUser.currentUser() == nil ){
            query.whereKeyDoesNotExist("user")
        }else{
            query.whereKey("user", equalTo: PFUser.currentUser()!)
        }
        // Load the service object
        query.includeKey("service")
        //query.orderByAscending(MyOtherKey)
        return query
    }

    // MARK : View Functions
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        if (isUserNotCreated()){
            self.performSegueWithIdentifier("serviceToAccount", sender: self)
            return;
        }
        
        self.loadObjects()
        self.tableView.reloadData()
        
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        noDataText = "Please subscribe to a service or a company with the add button"
        
        if (isUserNotCreated()){
            //self.performSegueWithIdentifier("serviceToAccount", sender: self)
            return;
        }
        
        PFUser.enableRevocableSessionInBackground();
        PFUser.currentUser()?.fetchInBackgroundWithBlock({ (object, error) in
            if (error != nil){
                PFUser.logOut();
                self.performSegueWithIdentifier("serviceToAccount", sender: self)
            }else{
                self.loadObjects()
                self.tableView.reloadData()
            }
        })
        self.tableView.reloadData()
        
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath, object: PFObject!) -> PFTableViewCell? {
        
        let cellIdentifier = "ServiceTableViewCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! ServiceTableViewCell
        let service:PFObject = object["service"] as! PFObject ;
        cell.serviceName.text = service["name"] as? String
        
        if ( indexPath.row % 2 == 0 ){
            cell.serviceImage.image = UIImage.fromColor(UIColor(red: 0, green: 0, blue: 1, alpha: 0.04))
        }else{
            // We don't load any color background
        }
        
        return cell
    }

    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 80;
    }
        
    // MARK : Transitions functions
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if  segue.identifier == "serviceToMessage" {
            let controller = segue.destinationViewController as! SharedMessageTableViewController
            
            //controller.transitioningDelegate = self.animatorController
            
            let cell = sender as! UITableViewCell
            let indexPath = self.tableView.indexPathForCell(cell) as NSIndexPath!
            
            self.currentIndexSelected = indexPath
            
            controller.service = self.objectAtIndexPath(indexPath)!["service"] as? PFObject
            //controller.delegate = self
        }else if  segue.identifier == "serviceToAccount" {
            let controller = segue.destinationViewController as! AccountViewController
            
            //controller.transitioningDelegate = self.animatorController
            
            if(isUserNotCreated()){
                controller.tutorial = true;
            }else{
                controller.tutorial = false;
            }
            //controller.delegate = self
        }
    }

    // MARK : Others
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension ServiceTableViewController{
    func isUserNotCreated() -> Bool{
        if ( PFUser.currentUser() == nil){
            return true;
        }
        return false;
    }
}
