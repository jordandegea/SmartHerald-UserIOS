//
//  MyPFLoginViewController.swift
//  SharedNews
//
//  Created by Jordan DE GEA on 26/07/2016.
//  Copyright © 2016 Parse. All rights reserved.
//

import ParseUI

class MyPFLogInViewController : PFLogInViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
            
        //self.view.backgroundColor = UIColor.darkGrayColor()
        
        let logoView = UIImageView(image: UIImage(named:"logo.png"))
        self.logInView!.logo = logoView
        //self.logInView!.logo = nil
    }

}