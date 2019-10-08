//
//  LocationDataDelegate.swift
//  WeatherApp
//
//  Created by Joonas Salojärvi on 08/10/2019.
//  Copyright © 2019 Joonas Salojärvi. All rights reserved.
//

import Foundation
import CoreLocation
protocol LocationDataDelegate {
    var currentLocation : CLLocation? {get set}
}
