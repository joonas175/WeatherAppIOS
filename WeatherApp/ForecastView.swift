//
//  ForecastView.swift
//  WeatherApp
//
//  Created by Joonas Salojärvi on 08/10/2019.
//  Copyright © 2019 Joonas Salojärvi. All rights reserved.
//

import Foundation
import UIKit

class ForecastView: UIViewController, LocationDataDelecate {
    var locationData: LocationDataModel?
    
    func onLocationDataChanged() {
        return
    }
    
    func onSelectedLocationChanged() {
        return
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
}
