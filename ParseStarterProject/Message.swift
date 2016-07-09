//
//  Message.swift
//  SharedNews
//
//  Created by Jordan DE GEA on 16/02/2016.
//  Copyright © 2016 Jordan DE GEA. All rights reserved.
//

import UIKit

class Message{
    
    var summary:String
    var content:String
    var image: UIImage?
    
    
    init?(summary: String, content: String, image: UIImage?) {
        // Initialize stored properties.
        self.summary = summary
        self.content = content
        self.image = image
        
        // Initialization should fail if there is no name or if the rating is negative.
        if summary.isEmpty || content.isEmpty {
            return nil
        }
    }
}