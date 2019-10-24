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
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var temp: UILabel!
    @IBOutlet weak var activityView: UIActivityIndicatorView!
    
    func onLocationDataChanged() {
        print("location changed")
        self.activityView.startAnimating()
        let config = URLSessionConfiguration.default
        
        let session = URLSession(configuration: config)
        
        let locDataObj = self.locationData!
        
        let coordinate = locDataObj.useSelectedLocation ? locDataObj.selectedLocation!.coordinate : locDataObj.currentLocation!.coordinate
        
        let url : URL? = URL(string: String(format: "http://api.openweathermap.org/data/2.5/weather?lat=%.6f&lon=%.6f&APPID=%@&units=metric", coordinate.latitude, coordinate.longitude, GlobalVariables.OWMkey))
        
        //print(url!)
        
        let task = session.dataTask(with: url!, completionHandler: doneFetching)
        
        task.resume()
    }
    
    func onSelectedLocationChanged() {
        self.onLocationDataChanged()
    }
    
    func doneFetching(data: Data?, response: URLResponse?, error: Error?){
        if let fail : Error = error {
            NSLog("Request failed with following error: %@", fail.localizedDescription)
            return
        }
        
        do {
            let jsonResponse = try JSONSerialization.jsonObject(with: data!, options: [])
            let jsonObject = jsonResponse as! [String: Any]
            
            if let city : String = jsonObject["name"] as? String {
                DispatchQueue.main.async(execute: {
                    self.cityLabel.text = city
                    self.locationData!.currentLocationName = city
                })
            }
            
            if let weather : [[String: Any]] = jsonObject["weather"] as? [[String: Any]] {
                if let icon : String = weather[0]["icon"] as? String {
                    DispatchQueue.main.async(execute: {
                        let image = UIImage(named: ImageHelper.getIconCode(icon))
                        self.icon.image = image
                    })
                }
            } else {
                print("Error setting icon")
            }
            
            if let main : [String: Any] = jsonObject["main"] as? [String: Any] {
                if let temp : Double = main["temp"] as? Double {
                    DispatchQueue.main.async(execute: {
                        self.temp.text = String(format: "%.1f °C", arguments: [temp])
                        self.activityView.stopAnimating()
                    })
                } else {
                    print("Failed to parse temperature")
                }
            }
            
            
            
            
            
        } catch let parsingError {
            print(parsingError)
        }
        
        
        
        
    
    }


    override func viewDidLoad() {
        self.activityView.hidesWhenStopped = true
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
}
