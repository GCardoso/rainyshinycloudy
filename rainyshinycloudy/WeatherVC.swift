//
//  WeatherVC.swift
//  rainyshinycloudy
//
//  Created by Guilherme Gomes Cardoso on 4/1/17.
//  Copyright © 2017 Guilherme Cardoso. All rights reserved.
//

import UIKit
import CoreLocation
import Alamofire

class WeatherVC: UIViewController, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate {

    @IBOutlet weak var currentDateLabel: UILabel!
    @IBOutlet weak var currentTempLabel: UILabel!
    @IBOutlet weak var currentCityLabel: UILabel!
    @IBOutlet weak var currentWeatherLabel: UILabel!
    @IBOutlet weak var currentWeatherImageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    let locationManager = CLLocationManager()
    var currentLocation: CLLocation!
    
    var currentWeather: CurrentWeather!
    var forecast: Forecast!
    var forecasts = [Forecast]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startMonitoringSignificantLocationChanges()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        currentWeather = CurrentWeather()
        
        
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        locationAuthStatus()
    }
    
    func locationAuthStatus() {
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            currentLocation = locationManager.location
            Location.sharedInstance.latitude = currentLocation.coordinate.latitude
            Location.sharedInstance.logintude = currentLocation.coordinate.longitude
            
            currentWeather.downloadWeatherDetails {
                //setup the UI with the downloaded data
                self.downloadForecastData {
                    self.updateMainUI()
                }
            }
        } else {
            locationManager.requestWhenInUseAuthorization()
            locationAuthStatus()
        }
    }
    
    func downloadForecastData(completed: @escaping DownloadComplete) {
//        let forecastURL = URL(string: FORECAST_URL)
        print(URL_DARK)
        Alamofire.request(URL_DARK).responseJSON { response in
            print(response.error ?? "no error")
            let result = response.result
            print(result.value!)
            if let dict = result.value as? Dictionary<String, AnyObject> {
//                if let list = dict["list"] as? [Dictionary<String, AnyObject>] {
                if let list = dict["daily"] as? [Dictionary<String, AnyObject>] {
//                    for obj in list {
//                        let forecast = Forecast(weatherDict: obj)
//                        self.forecasts.append(forecast)
//                    }
//                    self.forecasts.remove(at: 0)
                }
                self.tableView.reloadData()
            }
            completed()
        }
        
    }
    
    func updateMainUI() {
        currentDateLabel.text = currentWeather.date
        currentTempLabel.text = "\(currentWeather.currentTemp)"
        currentWeatherLabel.text = currentWeather.weatherType
        currentCityLabel.text = currentWeather._cityName
        currentWeatherImageView.image = UIImage(named: "\(currentWeather._weatherType.capitalized)")
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecasts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "weatherCell", for: indexPath) as? WeatherCell {
            let forecast = forecasts[indexPath.row]
            cell.configureCell(forecast: forecast)
            
            return cell
        } else {
            return WeatherCell()
        }
    }
}

