//
//  LocationDataModel.swift
//  WeatherApp
//
//  Created by Joonas Salojärvi on 09/10/2019.
//  Copyright © 2019 Joonas Salojärvi. All rights reserved.
//

import Foundation
import CoreLocation
class LocationDataModel {
    var _currentLocation : CLLocation?
    var currentLocation : CLLocation? {
        get {
            return self._currentLocation
        }
        set {
            self._currentLocation = newValue
            for listener in listeners {
                listener.onLocationDataChanged()
            }
        }
    }
    var currentLocationName: String?
    var _selectedLocation : CLLocation?
    var selectedLocation : CLLocation? {
        get {
            return self._selectedLocation
        }
        set {
            self._selectedLocation = newValue
            for listener in listeners {
                listener.onLocationDataChanged()
            }
        }
    }
    var useSelectedLocation: Bool = false
    var listeners : [LocationDataDelecate] = []
    
    func forceUpdate() {
        for listener in listeners {
            listener.onLocationDataChanged()
        }
    }
}
