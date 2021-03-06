//
//  ViewController.swift
//  Weather App 
//
//  Created by Visakh D on 03/11/21.
//

import UIKit
import CoreLocation


class ViewController: UIViewController {
    
    //    Objects & refferences of the classes
    var weatherObj = WeatherManager()
    let locationManager = CLLocationManager()
    var cellObj = WeatherViewCell()
    var weathertableobj = WeatherTable()
    var weatherDailyObj : WeatherDataDaily?
    var daily = [DailyStatus]()   // array to store the decoded data to show in the table
    
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
        weathertableobj.weatherManagerDelegate = self
    }
    
    
    @IBAction func navigationButton(_ sender: UIButton) { // button for updating the current location of the app
        locationManager.requestLocation()
        
    }
}

//MARK: - Text Field Delegate

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
        searchField.text = ""
    }
    
    
}

//MARK: - Table View Delegate


extension ViewController : UITableViewDelegate ,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return daily.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! WeatherViewCell
        let data = daily[indexPath.row]
        cell.configureCell(data: data)
        return cell
    }
}

//MARK: - Weather Delegate

extension ViewController : WeatherDelegate {
    func weatherInfo2(weatherDetails: WeatherDataDaily) {
        
        for elemts in weatherDetails.daily {
      
        let dailyStatus1 = DailyStatus(weatherDetails: elemts)
        daily.append(dailyStatus1)
        }
        DispatchQueue.main.async {
            self.weatherTableView.reloadData()
        }
    }
    
    func weatherInfo(weatherDetails: WeatherModel) {
        DispatchQueue.main.async {
            self.cityLabel.text = weatherDetails.cityname
            self.tempLabel.text = weatherDetails.temperatureString
            self.weatherImage.image = UIImage(systemName: weatherDetails.conditionName)
        }
    }
}

//MARK: - CLLocation Manager Delegate

extension ViewController : CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            locationManager.stopUpdatingLocation()
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            print(lat)
            print(lon)
            
            weatherObj.fetch(lat: lat, lon: lon)
            weathertableobj.fetch(lat: lat, lon: lon)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}


