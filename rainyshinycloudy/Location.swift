//
//  Location.swift
//  rainyshinycloudy
//
//  Created by Guilherme Gomes Cardoso on 4/15/17.
//  Copyright © 2017 Guilherme Cardoso. All rights reserved.
//

import CoreLocation

class Location {
    static var sharedInstance = Location()
    
    private init() {
        
    }
    
    var latitude: Double!
    var logintude: Double!
}
