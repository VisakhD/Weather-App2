//
//  WeaatherViewCell.swift
//  Weather App - 2
//
//  Created by Visakh D on 03/11/21.
//

import UIKit

protocol TableDataDelegate {
    func weatherDetails ()
}

class WeatherViewCell: UITableViewCell {


    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var minTempLabel: UILabel!
    @IBOutlet weak var weatherImageTable: UIImageView!
    @IBOutlet weak var maxTempLabel: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)


    }

   
}

