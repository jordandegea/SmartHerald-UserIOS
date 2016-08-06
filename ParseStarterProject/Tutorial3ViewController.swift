//
//  Tutorial3ViewController.swift
//  Smart Herald
//
//  Created by Jordan DE GEA on 06/08/2016.
//  Copyright © 2016 Parse. All rights reserved.
//

import UIKit

class Tutorial3ViewController: UIViewController {
    
    @IBOutlet weak var contentLabel: UILabel!
    @IBAction func onCloseButton(sender: AnyObject) {
        let pvc = self.parentViewController as! UIPageViewController
        pvc.dismissViewControllerAnimated(true) {}
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let patternImage:UIImage = UIImage(named: "cheap_diagonal_fabric.png")!
        self.view.backgroundColor = UIColor.init(patternImage: patternImage)
        
        contentLabel.text = NSLocalizedString("TOTURIAL__PAGE_3_CONTENT", comment: "content of tutorial page 3")
        
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
