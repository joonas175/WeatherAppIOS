//
//  ForecastTableItem.swift
//  WeatherApp
//
//  Created by Joonas Salojärvi on 21/10/2019.
//  Copyright © 2019 Joonas Salojärvi. All rights reserved.
//

import Foundation
import UIKit

class ForecastTableItem: UITableViewCell {
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var conditionAndTemp: UILabel!
    @IBOutlet weak var datetime: UILabel!
    
}
