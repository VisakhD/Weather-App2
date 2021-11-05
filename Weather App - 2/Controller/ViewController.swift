//
//  ViewController.swift
//  Weather App 
//
//  Created by Visakh D on 03/11/21.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {
    
    var weatherObj = WeatherManager()
    let locationManager = CLLocationManager()
    var cellObj = WeatherViewCell()
    var weathertableobj = WeatherTable()
    
    @IBOutlet weak var weatherTableView: WeatherTableViewController!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var searchField: UITextField!
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        weatherTableView.delegate = self
        weatherTableView.dataSource = self
        searchField.delegate = self
        weatherObj.weatherManagerDelegate = self
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        weatherTableView.reloadData()
//        cellObj.tableDelegate = self
        
        weatherObj.requestWith(url: "https://api.openweathermap.org/data/2.5/weather?appid=d5d12596e43c663d81581d6ea4447ffb&units=metric&q=london", responds: WeatherData.self) { respondsResult in
            switch respondsResult {
            case .success(let weatherDataObj) :
                 print(weatherDataObj)
            case .failure(let error) :
                print(error)
            }
        }
    }

    
    @IBAction func navigationButton(_ sender: UIButton) {
        locationManager.requestLocation()
        
    }
    
    
}
extension ViewController : UITextFieldDelegate {
    
    @IBAction func searchFieldButton(_ sender: UIButton) {
        searchField.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchField.endEditing(true)
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if searchField.text != "" {
            return true
        }else {
            searchField.placeholder = "Type Something"
            return false
        }
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        weatherObj.fetch(cityName: searchField.text!)
    }
    
   
}
extension ViewController : UITableViewDelegate ,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! WeatherViewCell
//        cell.updateCell(index: indexPath.row)
//        weatherTableView.reloadData()
        print(indexPath.row)
        return cell
    }
}

extension ViewController : WeatherDelegate {
    func weatherInfo(weatherDetails: WeatherModel) {
        DispatchQueue.main.async {
            self.cityLabel.text = weatherDetails.cityname
            self.tempLabel.text = weatherDetails.temperatureString
            self.weatherImage.image = UIImage(systemName: weatherDetails.conditionName)
        }
        
    }
    
    
    
}

extension ViewController : CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            locationManager.stopUpdatingLocation()
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
             print(lat)
             print(lon)
            
            weatherObj.fetch(lat: lat, lon: lon)
           
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}

//extension ViewController : TableDataDelegate {
//    func weatherDetails() {
//        weatherTableView.reloadData()
//
//    }
//}



