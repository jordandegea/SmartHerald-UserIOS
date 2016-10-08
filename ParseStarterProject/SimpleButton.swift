//
//  SimpleButton.swift
//  Smart Herald
//
//  Created by Jordan DE GEA on 08/10/2016.
//  Copyright © 2016 Parse. All rights reserved.
//
import UIKit

class SimpleButton: UIButton {
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        // set other operations after super.init, if required
        backgroundColor = .redColor()
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        
        
        layer.cornerRadius = 12
        layer.shadowColor = UIColor.blackColor().CGColor
        layer.shadowOpacity = 0.2
        layer.shadowOffset = CGSizeMake(0, 20)
        layer.shadowRadius = 10
        layer.borderColor = UIColor.blueColor().CGColor
        layer.borderWidth = 0.4
        
        
        
    }
    
}
