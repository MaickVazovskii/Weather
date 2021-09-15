//
//  WeatherData.swift
//  Weather
//
//  Created by Тимур Гутиев on 15.09.2021.
//

import Foundation

struct WeatherData: Decodable {
    var name: String
    var main: Main
    var weather: [Weather]
    
}

struct Main: Decodable {
    var temp: Double
    
    var stringTemp: String {
        return String(format: "%.0f", temp)
    }
}

struct Weather: Decodable {
    var id: Int
    var description: String
    
    var weatherCondition: String {
        switch id {
        case 701:
            return "cloud.fog"
        case 804:
            return "cloud.fill"
        case 801:
            return "cloud.sun"
        case 741:
            return "cloud.fog.fill"
        case 802:
            return "cloud.sun.fill"
        case 800:
            return "sun.max.fill"
        default:
            return "cloud"
        }
    }
}
