//
//  Tutorial1ViewController.swift
//  Smart Herald
//
//  Created by Jordan DE GEA on 06/08/2016.
//  Copyright © 2016 Parse. All rights reserved.
//

import UIKit

class Tutorial1ViewController: UIViewController {

    @IBOutlet weak var contentLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        let patternImage:UIImage = UIImage(named: "cheap_diagonal_fabric.png")!
        self.view.backgroundColor = UIColor.init(patternImage: patternImage)
        
        contentLabel.text = NSLocalizedString("TOTURIAL__PAGE_1_CONTENT", comment: "content of tutorial page 1")
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
