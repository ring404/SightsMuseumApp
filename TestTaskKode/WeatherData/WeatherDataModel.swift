//
//  WeatherResult.swift
//  TestTaskKode
//
//  Created by Dmitrii on 08.11.2020.
//

import Foundation
import SwiftUI

struct WeatherResult: Codable, Identifiable {
    let id = UUID()
    let hourly: [Hourly]
}

struct Hourly: Codable, Identifiable {
    let id = UUID()
    let dt: Double
    let temp, feelsLike: Double
    let pressure, humidity: Double
    let dewPoint: Double
    let clouds, visibility: Double
    let windSpeed: Double
    let windDeg: Double
    let weather: [Weather]
    let pop: Double

    enum CodingKeys: String, CodingKey {
        case dt, temp
        case feelsLike = "feels_like"
        case pressure, humidity
        case dewPoint = "dew_point"
        case clouds, visibility
        case windSpeed = "wind_speed"
        case windDeg = "wind_deg"
        case weather, pop
    }
}

struct Weather: Codable {
    let id: Int
    let main: String
    let weatherDescription: String
    let icon: String

    enum CodingKeys: String, CodingKey {
        case id, main
        case weatherDescription = "description"
        case icon
    }
}
