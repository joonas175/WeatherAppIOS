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

class CityView: UIViewController, LocationDataDelecate, UITableViewDelegate, UITableViewDataSource {
    
    
    
    var locationData: LocationDataModel?
    @IBOutlet weak var tableView: UITableView!
    var cities : [CityModel] = []
    @IBOutlet weak var addCityField: UITextField!
    let geoCoder : CLGeocoder = CLGeocoder()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cityCell") as! CityTableItem
        
        if(indexPath.row == 0){
            cell.cityLabel.text = "GPS: " + (locationData?.currentLocationName ?? "Unknown")
        } else {
            cell.cityLabel.text = cities[indexPath.row - 1].name!
            
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(indexPath.row == 0){
            self.locationData!.useSelectedLocation = false
            self.locationData!.forceUpdate()
        } else {
            print("using selected location")
            self.locationData!.useSelectedLocation = true
            self.locationData!.selectedLocation = cities[indexPath.row - 1].location!
        }
    }
    
    @IBAction func addCity(_ sender: Any) {
        let city = addCityField.text!
        self.geoCoder.geocodeAddressString(city, completionHandler: cityFound)
        
    }
    
    func cityFound(_ placemarks : [CLPlacemark]?, _ error : Error?) {
        if error != nil{
            print("Geocode error")
            return
        }
        
        let name = placemarks!.first!.name!
        let coordinates = placemarks!.first!.location!
        
        let newModel : CityModel = CityModel()
        newModel.location = coordinates
        newModel.name = name
        
        self.cities.append(newModel)
        
        tableView.reloadData()
    }
    
}
