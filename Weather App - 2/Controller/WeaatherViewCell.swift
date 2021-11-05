//
//  WeaatherViewCell.swift
//  Weather App - 2
//
//  Created by Visakh D on 03/11/21.
//

import UIKit

//protocol TableDataDelegate {
//    func weatherDetails ()
//}

class WeatherViewCell: UITableViewCell  {
    
//    var dailyObj :WeatherDataDaily?
//    var tableDelegate : TableDataDelegate?
    
    
    

    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var minTempLabel: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var maxTempLabel: UILabel!
    
//    var weatherObj2 = WeatherTable()
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

//        weatherObj2.weatherObjDelegate = self
        
    }
    
    
//    func weatherInfo2(weatherDetails: WeatherDataDaily) {
//      dailyObj = weatherDetails
//    }
  
//    func updateCell(index:Int) {
//        DispatchQueue.main.async {
//            self.dayLabel.text = "\(self.dailyObj?.daily[index].moonset)"
//            self.minTempLabel.text = weatherDetails.tempStringMin
//            self.maxTempLabel.text = weatherDetails.tempStringMax
//            self.weatherImage.image = UIImage(systemName: weatherDetails.conditionName)
//        }
    
//        tableDelegate?.weatherDetails()
//    }
    

}

