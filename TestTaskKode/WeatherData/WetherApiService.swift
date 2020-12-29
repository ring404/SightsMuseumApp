//
//  Api.swift
//  TestTaskKode
//
//  Created by Dmitrii on 08.11.2020.
//

import Foundation
import SwiftUI

class Api {

    let apiKey = "1d2d105ff4ef0dfe538cda8e7ceaac37"
    let cityLat = "40.6971494"
    let cityLong = "-74.2598636"
    let exclude = "current,minutely,daily,alerts"

    func getPosts(completion: @escaping (WeatherResult) -> Void) {

        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/onecall?lat=\(cityLat)&lon=\(cityLong)&exclude=\(exclude)&units=metric&appid=\(apiKey)") else {print("could not create url"); return}
        URLSession.shared.dataTask(with: url) { (data, response, error) in

            if error != nil {
                print(error!)
                return
            }

            if response != nil {
              //  print("RESPONSE IS : \(response!)\n\n")
            }

            guard let data = data else {
                print("data not returnd\n")
                return

            }

            let decoder = JSONDecoder()

            do {
                let result = try decoder.decode(WeatherResult.self, from: data)

                DispatchQueue.main.async {
                    print(result.hourly.debugDescription)
                    completion(result)

                }

            } catch {
                fatalError(error.localizedDescription)
            }

        }.resume()

    }
}
