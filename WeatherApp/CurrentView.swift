//
//  CurrentView.swift
//  WeatherApp
//
//  Created by Joonas Salojärvi on 08/10/2019.
//  Copyright © 2019 Joonas Salojärvi. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

class CurrentView: UIViewController, LocationDataDelegate {
    var currentLocation: CLLocation?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
}
