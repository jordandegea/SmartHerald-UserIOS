//
//  Service.swift
//  SmartHerald
//
//  Created by Jordan DE GEA on 22/02/2016.
//  Copyright © 2016 Jordan DE GEA. All rights reserved.
//

import UIKit

class Service{
    
    var name:String
    var description:String
    var image: UIImage?
    
    
    init?(name: String, description: String, image: UIImage?) {
        // Initialize stored properties.
        self.name = name
        self.description = description
        self.image = image
        
        // Initialization should fail if there is no name or if the rating is negative.
        if name.isEmpty || description.isEmpty {
            return nil
        }
    }
}