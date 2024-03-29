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

class SharedMessageTableViewController: AbstractMessageTableViewController {
    // MARK: Properties
    
    var service:PFObject?
    
    // MARK : Outlets
    
    // MARK : Parse Main Query
    
    override func baseQuery() -> PFQuery {
        let query = PFQuery(className: "Message")
        query.whereKey("service", equalTo: (service)!)
        query.whereKey("sent", equalTo: true)
        //query.orderByAscending(MyOtherKey)
        return query
    }

}
