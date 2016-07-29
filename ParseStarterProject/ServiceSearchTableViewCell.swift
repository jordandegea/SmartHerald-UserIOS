//
//  ServiceSearchTableViewCell.swift
//  Smart Herald
//
//  Created by Jordan DE GEA on 23/03/2016.
//  Copyright © 2016 Parse. All rights reserved.
//

import UIKit
import ParseUI

class ServiceSearchTableViewCell: PFTableViewCell {

    @IBOutlet weak var serviceName: UILabel!
    
    @IBOutlet weak var serviceImage: UIImageView!
    
    @IBOutlet weak var serviceDescription: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

}
