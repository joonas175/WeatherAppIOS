//
//  LocationDataDelecate.swift
//  WeatherApp
//
//  Created by Joonas Salojärvi on 09/10/2019.
//  Copyright © 2019 Joonas Salojärvi. All rights reserved.
//

import Foundation
protocol LocationDataDelecate {
    //Ooops typo in class
    var locationData : LocationDataModel? {get set}
    func onLocationDataChanged() -> Void
    func onSelectedLocationChanged() -> Void
}

extension LocationDataDelecate {
    func onLocationDataChanged() {
        
    }
    
    func onSelectedLocationChanged() {
        
    }
}
