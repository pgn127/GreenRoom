//
//  LocCell.swift
//  Assignment3
//
//  Created by Pamela Needle on 10/25/15.
//  Copyright © 2015 Daniel Del Core. All rights reserved.
//

import UIKit

class LocCell: UITableViewCell {

    
    
    
    @IBOutlet weak var timeLabel: UILabel!
    //@IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var swellLabel: UILabel!
    //@IBOutlet weak var windLabel: UILabel!
    
    //@IBOutlet weak var swellDir: UIImageView!
    //@IBOutlet weak var swellLabel: UILabel!
    @IBOutlet weak var windLabel: UILabel!
    //@IBOutlet weak var windDir: UIImageView!
    //@IBOutlet weak var swellDir: UIImageView!
    //@IBOutlet weak var windDir: UIImageView!
    
    var cellInfo: forecastDisplay? {
        //property observer triggered when property set
        didSet {
            if let disp = cellInfo {
                swellLabel.text = "Swell: \(disp.swellHeight)m \(disp.swelldir)"
                windLabel.text = "Wind: \(disp.windSpeed)knots \(disp.winddir)"
                timeLabel.text = disp.time
            } else {
                swellLabel.text = nil
                windLabel.text = nil
                timeLabel.text = nil
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
