//
//  MessageUIViewController.swift
//  Smart Herald
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
        
        var content = message?.valueForKey("content");
                if ( content == nil){
            navigationController?.popViewControllerAnimated(true)
        }else{
                    
            content = content?.stringByReplacingOccurrencesOfString("{$js_jquery}", withString:"http://code.jquery.com/jquery-3.1.1.min.js");
            content = content?.stringByReplacingOccurrencesOfString("{$bootswatch_cerulean}", withString:"https://cdnjs.cloudflare.com/ajax/libs/bootswatch/3.3.7/cerulean/bootstrap.min.css");
            content = content?.stringByReplacingOccurrencesOfString("{$js_jquery3.1.1}", withString:"http://code.jquery.com/jquery-3.1.1.min.js");
            content = content?.stringByReplacingOccurrencesOfString("{$bootstrap}", withString:"https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css");
            content = content?.stringByReplacingOccurrencesOfString("{$js_bootstrap}", withString:"https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js");
                    

                    
            webView.loadHTMLString(
                (content)! as! String,
                baseURL: nil)
        }
    }
}
