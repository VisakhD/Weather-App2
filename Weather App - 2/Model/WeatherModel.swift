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


//struct WeatherModel2 {
//    let conditionid : Int
//    let date : String
//    let temperatureMin : Double
//    let temperatureMax : Double
//
//    var tempStringMin : String {
//        return String(format: "%.1f", temperatureMin)
//    }
//    var tempStringMax : String {
//        return String(format: "%.1f", temperatureMax)
//    }
//
//    var conditionName : String {
//        switch conditionid {
//        case 200...232:
//            return "cloud.bolt.rain"
//        case 300...321:
//            return "cloud.drizzle"
//        case 500...531:
//            return "cloud.rain"
//        case 600...622:
//            return "cloud.snow"
//        case 701...781:
//            return "cloud.fog"
//        case 800:
//            return "sun.max"
//        case 801...804:
//            return "cloud.blot"
//        default:
//            return "cloud"
//        }
//    }
//}






