//
//  MessageTableViewCell.swift
//  Smart Herald
//
//  Created by Jordan DE GEA on 16/02/2016.
//  Copyright © 2016 Jordan DE GEA. All rights reserved.
//

import UIKit
import ParseUI

class MessageTableViewCell: PFTableViewCell {

    // MARK: Properties
    
    @IBOutlet weak var messageImage: UIImageView!
    
    @IBOutlet weak var messageSummary: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
