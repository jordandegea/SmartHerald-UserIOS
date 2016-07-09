//
//  ServiceTableViewCell.swift
//  SharedNews
//
//  Created by Jordan DE GEA on 22/02/2016.
//  Copyright © 2016 Jordan DE GEA. All rights reserved.
//

import UIKit
import ParseUI


class ServiceTableViewCell: PFTableViewCell {

    @IBOutlet weak var serviceName: UILabel!
    
    @IBOutlet weak var serviceImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

}
