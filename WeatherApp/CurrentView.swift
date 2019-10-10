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

class CurrentView: UIViewController, LocationDataDelecate {
    var locationData: LocationDataModel?
    
    func onLocationDataChanged() {
        let config = URLSessionConfiguration.default
        
        let session = URLSession(configuration: config)
        
        let coordinate = self.locationData!.currentLocation!.coordinate
        
        let url : URL? = URL(string: String(format: "api.openweathermap.org/data/2.5/weather?lat=%.6f&lon=%.6f&APPID=%@", coordinate.latitude, coordinate.longitude, GlobalVariables.OWMkey))
        
        print(url!)
        
        //let task = session.dataTask(with: url!, completionHandler: doneFetching) //kaatuu?
        
        task.resume()
    }
    
    func doneFetching(data: Data?, response: URLResponse?, error: Error?){
        print(response!)
        //let resstr = String(data: data!, encoding: String.Encoding.utf8)
        
    
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
}
