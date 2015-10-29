//
//  ContentViewController.swift
//  assignment4
//
//  Created by Daniel Del Core on 28/10/2015.
//  Copyright © 2015 Daniel Del Core. All rights reserved.
//

import UIKit

class ContentViewController: UIViewController {
    
    var pageIndex: Int!
    var model: Forcast!
    
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!

    @IBOutlet weak var windSpeed: UILabel!
    @IBOutlet weak var windDirection: UILabel!
    @IBOutlet weak var windImage: UIImageView!
    
    @IBOutlet weak var swellDirection: UILabel!
    @IBOutlet weak var swellSize: UILabel!
    @IBOutlet weak var swellImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.dayLabel.text = self.model.day
        self.timeLabel.text = self.model.hour
        self.windSpeed.text = self.model.windSpeed
        self.windDirection.text = self.model.windDirection
        self.swellDirection.text = self.model.swellDirection
        self.swellSize.text = self.model.swellHeightMetres
        
        let windDeg:CGFloat = CGFloat(self.model.windDirectionDeg)
        let swellDeg:CGFloat = CGFloat(self.model.swellDirectionDeg)
        
        UIView.animateWithDuration(1.0, animations: {
            self.windImage.transform = CGAffineTransformMakeRotation((windDeg * CGFloat(M_PI)) / 180.0)
        })
        
        UIView.animateWithDuration(1.0, animations: {
            self.swellImage.transform = CGAffineTransformMakeRotation((swellDeg * CGFloat(M_PI)) / 180.0)
        });
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}