//
//  WeatherManager.swift
//  Weather App - 2
//
//  Created by Visakh D on 03/11/21.
//

import UIKit
import CoreLocation


protocol WeatherDelegate {
    func weatherInfo(weatherDetails : WeatherModel)
    func weatherInfo2(weatherDetails : WeatherDataDaily)
}

//MARK: - Weather Manager to populate the current weather details

struct WeatherManager {
    
    let weatherUrl = "https://api.openweathermap.org/data/2.5/weather?appid=d5d12596e43c663d81581d6ea4447ffb&units=metric"
    
    var  weatherManagerDelegate : WeatherDelegate?
    
    func fetch(cityName : String){
        let strlUrl = "\(weatherUrl)&q=\(cityName)" // string interpolation used to add city name to url
        request(url: strlUrl)
    }
    
    func fetch(lat:CLLocationDegrees, lon: CLLocationDegrees){
        
        let strlUrl = "\(weatherUrl)&lat=\(lat)&lon=\(lon)" // string interpolation used to add lat & log to url
        request(url: strlUrl)
        print(strlUrl)
    }
    
    func request(url:String) {
        if  let url = URL(string: url) {
            let session  = URLSession(configuration:.default)
            
            let task = session.dataTask(with: url) { data, resp, error in
                if error != nil {
                    print(error!)
                }
                if let getdata = data {
                    let weather = parseJSON(weatherData: getdata)
                    weatherManagerDelegate?.weatherInfo(weatherDetails: weather!)  // passing data using delegate
                }
            }
            task.resume()
        }
    }
    
    // Parsing the data using JSONDecoder
    
    func parseJSON(weatherData : Data ) -> WeatherModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let id = decodedData.weather[0].id
            let temp = decodedData.main.temp
            let name = decodedData.name
            let weatherInfo = WeatherModel(conditionid: id, cityname: name, temperature: temp)
            return weatherInfo
        } catch  {
            print(error)
        }
        return nil
    }
}

//MARK: - Weather Table is used to populate Table View Weather

struct WeatherTable {
    
    let weatherUrlTable = "https://api.openweathermap.org/data/2.5/onecall?exclude=current,hourly,minutely,alerts&appid=d5d12596e43c663d81581d6ea4447ffb&units=metric"
    
    var  weatherManagerDelegate : WeatherDelegate?
    
    func fetch(lat:CLLocationDegrees, lon: CLLocationDegrees){
        
        let strlUrl = "\(weatherUrlTable)&lat=\(lat)&lon=\(lon)" // string interpolation used to add lat & log to url
        request(url: strlUrl)
        print(strlUrl)
    }
    
    func request(url:String) {
        if  let url = URL(string: url) {
            let session  = URLSession(configuration:.default)
            
            let task = session.dataTask(with: url) { data, resp, error in
                if error != nil {
                    print(error!)
                }
                if let getdata = data {
                    let weather = parseJSON(weatherData: getdata)
                    weatherManagerDelegate?.weatherInfo2(weatherDetails: weather!)  // passing data using delegate
                }
            }
            task.resume()
        }
    }
    
    // Parsing the data using JSONDecoder
    
    func parseJSON(weatherData : Data ) -> WeatherDataDaily? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherDataDaily.self, from: weatherData)
            return decodedData
        }
        catch  {
            print(error)
        }
        return nil
    }
}






















