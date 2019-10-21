//
//  ImageHelper.swift
//  WeatherApp
//
//  Created by Joonas Salojärvi on 21/10/2019.
//  Copyright © 2019 Joonas Salojärvi. All rights reserved.
//

import Foundation
class ImageHelper {
    static func getIconCode(_ code : String) -> String{
        switch code {
        case "03d", "03n":
            return "03d"
        case "04d", "04n":
            return "04d"
        case "09d", "09n":
            return "09d"
        case "11d", "11n":
            return "11d"
        case "13d", "13n":
            return "13d"
        case "50d", "50n":
            return "50d"
        default:
            return code
        }
    }
}
