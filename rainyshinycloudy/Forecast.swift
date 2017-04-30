//
//  Forecast.swift
//  rainyshinycloudy
//
//  Created by Guilherme Gomes Cardoso on 4/10/17.
//  Copyright © 2017 Guilherme Cardoso. All rights reserved.
//

import UIKit
import Alamofire

class Forecast {
    
    private var _date: String!
    private var _weatherType: String!
    private var _highTemp: String!
    private var _lowTemp: String!
    
    var date: String {
        if self._date == nil {
            self._date = ""
        }
        return self._date
    }
    
    var weatherType: String {
        if self._weatherType == nil {
            self._weatherType = ""
        }
        return self._weatherType
    }
    
    var highTemp: String {
        if self._highTemp == nil {
            self._highTemp = ""
        }
        return self._highTemp
    }
    
    var lowTemp: String {
        if self._lowTemp == nil {
            self._lowTemp = ""
        }
        return self._lowTemp
    }
    
    init(weatherDict: Dictionary<String, AnyObject>) {
        if let temp = weatherDict["temp"] as? Dictionary<String, AnyObject> {
            
            if let min = temp["min"] as? Double{
                let kelvinToCelsius = min - 273.15
                self._lowTemp = "\(Double(round(100 * kelvinToCelsius) / 100))"
            }
            
            if let max = temp["max"] as? Double{
                let kelvinToCelsius = max - 273.15
                self._highTemp = "\(Double(round(100 * kelvinToCelsius) / 100))"
            }
        }
        
        if let weather = weatherDict["weather"] as? [Dictionary<String, AnyObject>] {
            
            if let main = weather[0]["main"] as? String {
                self._weatherType = main
            }
            
        }
        
        if let date = weatherDict["dt"] as? Double {
            let unixConvertedDate = Date(timeIntervalSince1970: date)
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .full
            dateFormatter.timeStyle = .none
            
            self._date = unixConvertedDate.dayOfTheWeek()
        }
        
    }
}

extension Date {
    func dayOfTheWeek() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        
        return dateFormatter.string(from: self)
    }
}


