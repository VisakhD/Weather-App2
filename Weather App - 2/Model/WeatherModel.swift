//
//  WeatherModel.swift
//  Weather App - 2
//
//  Created by Visakh D on 03/11/21.
//

import Foundation

struct WeatherModel {
    let conditionid : Int
    let cityname : String
    let temperature : Double
    
    var temperatureString : String {
        return String(format: "%.1f", temperature)
    }
    
    var conditionName : String {
        switch conditionid {
        case 200...232:
            return "cloud.bolt.rain"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.rain"
        case 600...622:
            return "cloud.snow"
        case 701...781:
            return "cloud.fog"
        case 800:
            return "sun.max"
        case 801...804:
            return "cloud.blot"
        default:
            return "cloud"
        }
    }
}

struct DailyStatus {
    var dateInfo : Int
    var temperatureMinimum : Double
    var temperratureMaximum : Double
    let  weatherImageDailyTable : Int
    var day : String
    var conditionName : String {
     switch weatherImageDailyTable {
     case 200...232:
         return "cloud.bolt.rain"
     case 300...321:
         return "cloud.drizzle"
     case 500...531:
         return "cloud.rain"
     case 600...622:
         return "cloud.snow"
     case 701...781:
         return "cloud.fog"
     case 800:
         return "sun.max"
     case 801...804:
         return "cloud.blot"
     default:
         return "cloud"
     }
 }
    
    init(weatherDetails: WeatherDataDaily) {
        self.dateInfo = weatherDetails.daily[0].dt
        
        self.temperatureMinimum = weatherDetails.daily[0].temp.min
        self.temperratureMaximum = weatherDetails.daily[0].temp.max
        self.weatherImageDailyTable = weatherDetails.daily[0].weather[0].id
        
        let date = Date(timeIntervalSinceReferenceDate: TimeInterval(dateInfo)) // DATE formatter
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE"
        let day = formatter.string(from: date)
        self.day = day                           //
       
        
    

        
        
           
        
    }
 
}




