//
//  CityModel.swift
//  WeatherApp
//
//  Created by Joonas Salojärvi on 22/10/2019.
//  Copyright © 2019 Joonas Salojärvi. All rights reserved.
//

import Foundation
import CoreLocation

class CityModel: NSObject, NSCoding {
    
    var name : String?
    var location: CLLocation?
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name!, forKey: "cityName")
        aCoder.encode(location!, forKey: "location")
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.location = aDecoder.decodeObject(forKey: "location") as? CLLocation
        self.name = aDecoder.decodeObject(forKey: "cityName") as? String
    }
    
    override init() {
        
    }

}
