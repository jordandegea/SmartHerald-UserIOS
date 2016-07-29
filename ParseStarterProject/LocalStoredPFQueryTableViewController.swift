//
//  LocalStoredPFQueryTableViewController.swift
//  Smart Herald
//
//  Created by Jordan DE GEA on 01/03/2016.
//  Copyright © 2016 Parse. All rights reserved.
//

import Parse
import ParseUI


class LocalStoredPFQueryTableViewController:PFQueryTableViewController{
    
    var shouldUpdateFromServer:Bool = true
    var noDataLabel:UILabel? = nil;
    var noDataText:String = "";
    
    func baseQuery() -> PFQuery {fatalError("Must Override")}
    
    override func objectsDidLoad(error: NSError?) {
        super.objectsDidLoad(error)
        // If we just updated from the server, do nothing, otherwise update from server.
        if self.shouldUpdateFromServer {
            self.refreshLocalDataStoreFromServer()
        } else {
            self.shouldUpdateFromServer = true
        }
    }
    override func queryForTable() -> PFQuery {
        return self.baseQuery().fromLocalDatastore()
    }
    
    func refreshLocalDataStoreFromServer() {
        self.baseQuery().findObjectsInBackgroundWithBlock ({(objects:[PFObject]?, error:NSError?) -> Void in
            if error == nil {
                //print("Found \(objects!.count) parseObjects from server")
                // First, unpin all existing objects
                
                PFObject.unpinAllInBackground (self.objects as? [PFObject], block: { (succeeded: Bool, error: NSError?) -> Void in
                    if error == nil {
                        // Pin all the new objects
                        PFObject.pinAllInBackground(objects, block: { (succeeded: Bool, error: NSError?) -> Void in
                            if error == nil {
                                // Once we've updated the local datastore, update the view with local datastore
                                self.shouldUpdateFromServer = false
                                self.loadObjects()
                            } else {
                                //print("Failed to pin objects")
                            }
                        })
                    }
                })
            } else {
                //print("Couldn't get objects")
            }
        })
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let num:Int = objects!.count;
        if ( noDataLabel == nil ){
            noDataLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.tableView.bounds.size.width, height: self.tableView.bounds.size.height));
            noDataLabel!.textColor        = UIColor.blackColor();
            noDataLabel!.textAlignment    = NSTextAlignment.Center;
        }
        if (num > 0)
        {
            self.tableView.separatorStyle = UITableViewCellSeparatorStyle.SingleLine;
            noDataLabel!.text             = "";
        }
        else
        {
            noDataLabel!.text             = noDataText;
            self.tableView.backgroundView = noDataLabel;
            self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None;
        }
        
        return num;
    }

}
