//
//  ServiceSearchTableViewController.swift
//  Smart Herald
//
//  Created by Jordan DE GEA on 23/03/2016.
//  Copyright © 2016 Parse. All rights reserved.
//

import UIKit
import Parse
import ParseUI
import CoreData

@available(iOS 8.0, *)
class ServiceSearchTableViewController: LocalStoredPFQueryTableViewController, UISearchBarDelegate  {

    // MARK: Properties
    
    var currentIndexSelected : NSIndexPath!
    
    var searchContent : String = "####" ;
    // MARK : Outlets
    
    @IBAction func onCancelSelected(sender: AnyObject) {
        
        dismissViewControllerAnimated(true, completion: {})
    }
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    // MARK : Parse Main Query
    
    override func baseQuery() -> PFQuery {
        var canonicalNameSearch = searchContent.lowercaseString ;
        canonicalNameSearch = canonicalNameSearch.componentsSeparatedByString(" ").joinWithSeparator("+")
        
        let query = PFQuery(className: "Service")
        query.whereKey("canonicalName", containsString: canonicalNameSearch)
        query.orderByAscending("canonicalName")
        //query.orderByAscending(MyOtherKey)
        return query
    }
    
    // MARK : View Functions
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
         
        self.loadObjects()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.reloadData()
        noDataText = "No results for this keyword"
        searchBar.delegate = self
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        
        //self.tableView.reloadData()
        if ( searchText.characters.count > 1){
            searchContent = searchText
            self.loadObjects()
        }
    }
    
    
    
    // MARK: - Table view data source

    //var sortedObjects:[AnyObject]
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath, object: PFObject!) -> PFTableViewCell? {
        
        let cellIdentifier = "ServiceSearchTableViewCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! ServiceSearchTableViewCell
        
        cell.serviceName.text = object["name"] as? String
        cell.serviceDescription.text = object["description"] as? String
        
        if ( indexPath.row % 2 == 0 ){
            cell.serviceImage.image = UIImage.fromColor(UIColor(red: 0, green: 0, blue: 1, alpha: 0.04))
        }else{
            // We don't load any color background
        }
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        let service:PFObject =  objectAtIndexPath(indexPath)!  ;
        
        let selfP = self ;
        
        PFCloud.callFunctionInBackground(
            "subscribe",
            withParameters: [
            "serviceId":service.objectId!,
        ]) {
            (response, error) in
            PFCloud.callFunctionInBackground(
                "update_installation",
                withParameters: [
                    "installationId":PFInstallation.currentInstallation().objectId!,
            ])
            if (error == nil) {
                selfP.dismissViewControllerAnimated(true, completion: {})
            }
        }
        
        /*
        
        let query = PFQuery(className:"UsersServices")
        query.whereKey("user", equalTo: PFUser.currentUser()!)
        query.whereKey("service", equalTo:service)
        query.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?) -> Void in
            
            if error == nil {
                if ( objects!.count == 0 ){
                    let usersServices = PFObject(className:"UsersServices")
                    usersServices["user"] = PFUser.currentUser();
                    usersServices["service"] = service;
                    usersServices["notification"] = true ;
                    usersServices.saveInBackgroundWithBlock {
                        (success: Bool, error: NSError?) -> Void in
                        if (success) {
                            selfP.dismissViewControllerAnimated(true, completion: {})
                        } else {
                            print("edit user failed")
                        }
                    }
                }else{
                    let refreshAlert = UIAlertController(title: "Subscription", message: "You already subscribed this company", preferredStyle: UIAlertControllerStyle.Alert)
                    
                    refreshAlert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { (action: UIAlertAction!) in
                        
                    }))
                    
                    selfP.presentViewController(refreshAlert, animated: true, completion: nil)
                }
            } else {
                // Log details of the failure
                let refreshAlert = UIAlertController(title: "Subscription", message: "An error occured when trying to subscribe. Retry later. ", preferredStyle: UIAlertControllerStyle.Alert)
                
                refreshAlert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { (action: UIAlertAction!) in
                    
                }))
                
                selfP.presentViewController(refreshAlert, animated: true, completion: nil)
                print("Error: \(error!) \(error!.userInfo)")
            }
        }
        
        */
        let settings = UIUserNotificationSettings(forTypes: [.Alert, .Badge, .Sound], categories: nil)
        UIApplication.sharedApplication().registerUserNotificationSettings(settings)
        UIApplication.sharedApplication().registerForRemoteNotifications()
        
        
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100;
    }
    
    
    
    // MARK : Others
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
