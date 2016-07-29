//
//  MessageTableViewController.swift
//  Smart Herald
//
//  Created by Jordan DE GEA on 16/02/2016.
//  Copyright © 2016 Jordan DE GEA. All rights reserved.
//

import UIKit
import ParseUI
import Parse

class StandaloneMessageTableViewController: AbstractMessageTableViewController {
    
    // MARK : Parse Main Query
    
    override func baseQuery() -> PFQuery {
        let service = PFObject(outDataWithClassName: "Service", objectId: (NSBundle.mainBundle().objectForInfoDictionaryKey("PARSE_COMPANY_ID") as! String))
        
        let query = PFQuery(className: "Message")
        query.whereKey("service", equalTo: service)
        query.whereKey("sent", equalTo: true)
        //query.orderByAscending(MyOtherKey)
        return query
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.title = (NSBundle.mainBundle().objectForInfoDictionaryKey("CFBundleName") as! String)
        noDataText = "No message to display"
    }
}
