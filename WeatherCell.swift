//
//  WeatherCell.swift
//  rainyshinycloudy
//
//  Created by Guilherme Gomes Cardoso on 4/10/17.
//  Copyright © 2017 Guilherme Cardoso. All rights reserved.
//

import UIKit

class WeatherCell: UITableViewCell {
    
    @IBOutlet weak var weatherIcon: UIImageView!
    
    @IBOutlet weak var lowTemp: UILabel!
    @IBOutlet weak var highTemp: UILabel!
    @IBOutlet weak var weatherType: UILabel!
    @IBOutlet weak var dayLabel: UILabel!
    
    func configureCell(forecast: Forecast) {
        lowTemp.text = "\(forecast.lowTemp)"
        highTemp.text = "\(forecast.highTemp)"
        weatherType.text = forecast.weatherType
        dayLabel.text = forecast.date
        
        weatherIcon.image = UIImage(named: "\(forecast.weatherType)")
    }
}
