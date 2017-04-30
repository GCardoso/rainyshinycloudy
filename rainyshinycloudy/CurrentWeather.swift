//
//  CurrentWeather.swift
//  rainyshinycloudy
//
//  Created by Guilherme Gomes Cardoso on 4/2/17.
//  Copyright © 2017 Guilherme Cardoso. All rights reserved.
//

import UIKit
import Alamofire

class CurrentWeather {
    var _cityName: String!
    var _date: String!
    var _weatherType: String!
    var _currentTemp: Double!
    
    var cityName: String {
        if _cityName == nil {
            _cityName = ""
        }
        return self._cityName
    }
    
    var weatherType: String {
        if _weatherType == nil {
            _weatherType = ""
        }
        return self._weatherType
    }
    
    var currentTemp: Double {
        if _currentTemp == nil {
            _currentTemp = 0.0
        }
        return self._currentTemp
    }
    
    var date: String {
        if _date == nil {
            _date = ""
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none
        let currentDate = dateFormatter.string(from: Date())
        self._date = "Today, \(currentDate)"
        return self._date
    }
    
    func downloadWeatherDetails(completed: @escaping DownloadComplete) {
        //alamofire download
//        let currentWeatherURL = URL(string: CURRENT_WEATHER_URL)!
        print(URL_DARK)
        Alamofire.request(URL_DARK).responseJSON { response in
            let result = response.result
            
            if let dict = result.value as? Dictionary<String, AnyObject> {
//                if let name = dict["name"] as? String {
                if let name = dict["timezone"] as? String {
                    self._cityName = name.capitalized
                    print(self._cityName)
                }
                
//                if let weather = dict["weather"] as? [Dictionary<String, AnyObject>], let main = weather[0]["main"] as? String {
                if let weather = dict["currently"] as? Dictionary<String, AnyObject>, let main = weather["summary"] as? String {
                
                    self._weatherType = main.capitalized
                    print(self._weatherType)
                }
                
//                if let main = dict["main"] as? Dictionary<String, AnyObject> {
                if let main = dict["currently"] as? Dictionary<String, AnyObject> {
//                    if let currentTemperature = main["temp"] as? Double {
                    if let currentTemperature = main["temperature"] as? Double {
                        let farenheitToCelcius = (currentTemperature - 32) / 1.8
                        self._currentTemp = Double(round(100 * (currentTemperature - 32) / 1.8) / 100)
//                        let kelvinToCelsius = currentTemperature - 273.15
//                        self._currentTemp = Double(round(100 * kelvinToCelsius) / 100)
                        print(self._currentTemp)
                    }
                }
            }
        completed()   
        }
    }
}
