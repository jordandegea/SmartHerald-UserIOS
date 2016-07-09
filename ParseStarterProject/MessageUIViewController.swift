//
//  MessageUIViewController.swift
//  SharedNews
//
//  Created by Jordan DE GEA on 01/03/2016.
//  Copyright © 2016 Parse. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class MessageUIViewController: UIViewController {

    
    var message:PFObject?
    
    @IBOutlet var webView: UIWebView!
    
    override func viewWillAppear(animated: Bool) {
        super.viewDidAppear(animated)
        if ( message?.valueForKey("content") == nil){
            navigationController?.popViewControllerAnimated(true)
        }else{
            webView.loadHTMLString(
                (message?.valueForKey("content"))! as! String,
                baseURL: nil)
        }
    }
}
