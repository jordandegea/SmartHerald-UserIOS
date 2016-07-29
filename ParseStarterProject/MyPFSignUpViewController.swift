//
//  MyPfSignUpViewController.swift
//  Smart Herald
//
//  Created by Jordan DE GEA on 26/07/2016.
//  Copyright © 2016 Parse. All rights reserved.
//
import ParseUI


class MyPFSignUpViewController : PFSignUpViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.view.backgroundColor = UIColor.darkGrayColor()
        
        let logoView = UIImageView(image: UIImage(named:"logo.png"))
        self.signUpView!.logo = logoView
        
        //self.signUpView!.logo = nil
    }
    
}