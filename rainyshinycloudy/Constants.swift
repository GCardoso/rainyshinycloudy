//
//  Constants.swift
//  rainyshinycloudy
//
//  Created by Guilherme Gomes Cardoso on 4/2/17.
//  Copyright © 2017 Guilherme Cardoso. All rights reserved.
//

import Foundation

typealias DownloadComplete = () -> ()

let BASE_URL = "/http://api.openweathermap.org/data/2.5/weather?"
let BASE_URL_FORECAST = "/http://api.openweathermap.org/data/2.5/forecast/daily?"
let LATITUDE = "lat="
let LONGITUDE = "&lon="
let APP_ID = "&appid="
let API_KEY = "fb281d431327493df6ccf0bcb0a76235"

let BASE_URL_DARK = "https://api.darksky.net/forecast/"
let API_KEY_DARK = "fb281d431327493df6ccf0bcb0a76235"
let URL_DARK = "\(BASE_URL_DARK)\(API_KEY_DARK)/\(Location.sharedInstance.latitude!),\(Location.sharedInstance.logintude!)"


let CURRENT_WEATHER_URL = "\(BASE_URL)\(LATITUDE)\(Location.sharedInstance.latitude!)\(LONGITUDE)\(Location.sharedInstance.logintude!)\(APP_ID)\(API_KEY)"
let FORECAST_URL = "\(BASE_URL_FORECAST)\(LATITUDE)\(Location.sharedInstance.latitude!)\(LONGITUDE)\(Location.sharedInstance.logintude!)&cnt=10\(APP_ID)\(API_KEY)"
