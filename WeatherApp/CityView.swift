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
    var selectedCity : IndexPath?
    let geoCoder : CLGeocoder = CLGeocoder()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if let citiesData = UserDefaults.standard.data(forKey: "cities") {
            print("löyty")
            do {
                self.cities =  try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(citiesData) as! [CityModel]
                tableView.reloadData()
            } catch {
                print("parse error")
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let selected : IndexPath = selectedCity {
            self.tableView.selectRow(at: selected, animated: false, scrollPosition: .none)
            
        }
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.selectedCity = self.tableView.indexPathForSelectedRow
        super.viewWillDisappear(animated)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cityCell") as! CityTableItem
        
        if(indexPath.row == 0){
            cell.cityLabel.text = "GPS: " + (locationData?.currentLocationName ?? "Unknown")
            cell.removeBtn.isHidden = true
        } else {
            cell.cityLabel.text = cities[indexPath.row - 1].name!
            cell.removeBtn.tag = indexPath.row
            cell.removeBtn.addTarget(self, action: #selector(removeButtonPressed), for: .touchUpInside)
        }
        
        return cell
    }
    
    func onLocationDataChanged() {
        if let _ = self.tableView {
            
        }
        
    }
    
    @objc func removeButtonPressed (sender:UIButton) {
        
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
        
        do {
            let data = try NSKeyedArchiver.archivedData(withRootObject: self.cities, requiringSecureCoding: false)
            UserDefaults.standard.set(data, forKey: "cities")
            //UserDefaults.standard.set(self.cities, forKey: "vittu")
        } catch {
            print("couldnt write to disk")
        }
    }
    
}
