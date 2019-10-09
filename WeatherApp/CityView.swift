//
//  CityView.swift
//  WeatherApp
//
//  Created by Joonas Salojärvi on 08/10/2019.
//  Copyright © 2019 Joonas Salojärvi. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

class CityView: UIViewController, LocationDataDelecate {
    
    func onLocationDataChanged() {
        return
    }
    
    func onSelectedLocationChanged() {
        return
    }
    
    var locationData: LocationDataModel?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
}
