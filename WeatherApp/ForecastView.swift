//
//  ForecastView.swift
//  WeatherApp
//
//  Created by Joonas Salojärvi on 08/10/2019.
//  Copyright © 2019 Joonas Salojärvi. All rights reserved.
//

import Foundation
import UIKit

class ForecastView: UITableViewController, LocationDataDelecate {
    var locationData: LocationDataModel?
    var forecasts : [WeatherData] = []
    var dateFormatter = DateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.dateFormatter.dateStyle = .full
        self.dateFormatter.timeStyle = .short
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecasts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "forecastCell", for: indexPath) as! ForecastTableItem
        
        let forecast = forecasts[indexPath.row]
        
        cell.conditionAndTemp.text = NSString(format: "%@ %.1f °C", forecast.condition!, forecast.temperature!) as String
        
        let image = UIImage(named: ImageHelper.getIconCode(forecast.icon!))
        cell.icon.image = image
        
        let dt = Date(timeIntervalSince1970: TimeInterval(forecast.datetime!))
        
        cell.datetime.text = self.dateFormatter.string(from: dt)
        
        
        return cell
    }
    
    func onLocationDataChanged() {
        let config = URLSessionConfiguration.default
        
        let session = URLSession(configuration: config)
        
        let locDataObj = self.locationData!
        
        let coordinate = locDataObj.useSelectedLocation ? locDataObj.selectedLocation!.coordinate : locDataObj.currentLocation!.coordinate
        
        let url : URL? = URL(string: String(format: "http://api.openweathermap.org/data/2.5/forecast?lat=%.6f&lon=%.6f&APPID=%@&units=metric", coordinate.latitude, coordinate.longitude, GlobalVariables.OWMkey))
        
        let task = session.dataTask(with: url!, completionHandler: doneFetching)
        
        task.resume()
    }
    
    func onSelectedLocationChanged() {
        onLocationDataChanged()
    }
    
    func doneFetching(data: Data?, response: URLResponse?, error: Error?){
        if let fail : Error = error {
            NSLog("Request failed with following error: %@", fail.localizedDescription)
            return
        }
        
        do {
            let jsonResponse = try JSONSerialization.jsonObject(with: data!, options: [])
            
            let jsonObject = jsonResponse as! [String: Any]
            
            if let list : [[String: Any]] = jsonObject["list"] as? [[String: Any]] {
                var newForecasts : [WeatherData] = []
                for item in list {
                    let newEntry = WeatherData()
                    
                    if let dt : Int = item["dt"] as? Int {
                        newEntry.datetime = dt
                    }
                    
                    if let weather : [[String: Any]] = (item["weather"] as? [[String : Any]]) {
                        
                        newEntry.condition = (weather[0]["main"] as? String)
                        newEntry.icon = (weather[0]["icon"] as! String)
                    }
                    
                    if let main : [String: Any] = (item["main"] as? [String : Any]){
                        newEntry.temperature = (main["temp"] as! Double)
                    }
                    newForecasts.append(newEntry)
                }
                
                DispatchQueue.main.async {
                    self.forecasts = newForecasts
                    
                    self.tableView.reloadData()
                }
                
            }
        } catch {
            print("Failed to parse json")
        }
    }
}
