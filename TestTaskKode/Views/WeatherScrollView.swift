//
//  WeatherScroll.swift
//  TestTaskKode
//
//  Created by Dmitrii on 06.11.2020.
//

import SwiftUI
import MapKit

struct WeatherScroll: View {

    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                Rectangle()
                    .frame(width: 18, alignment: .leading)
            }.ignoresSafeArea(SafeAreaRegions.container, edges: .horizontal)

        }.frame(width: UIScreen.screenWidth, height: 120, alignment: .leading)
    }
}

struct WeatherScrollArr: View {
//    var weatherArray =  Api().getPosts(completion: [Hourly]())
//    var weatherMain = weatherArray.weather[0].main
    @State var hourlyResults  = [Hourly]()
//    here I need to finish the slicing
    @State var todaysHourlyResults = ArraySlice<Hourly>()
    @State var tomorrowsHourlyResults = ArraySlice<Hourly>()
    var whichDay :String
    var currentCityCoord:CLLocationCoordinate2D
    
    let currentHour = Calendar.current.component(.hour, from: Date())
   let hoursLastsToday = 24 - Calendar.current.component(.hour, from: Date())
    let indexWhenTomorrowEnds = 24 + Calendar.current.component(.hour, from: Date())
    

    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                if whichDay == "Today" {
                    
                    
                    ForEach(todaysHourlyResults.indices, id: \.self) { index in
                        if index <= hoursLastsToday {
                        WeatherSquare(temp: todaysHourlyResults[index].temp, main: todaysHourlyResults[index].weather[0].main, icon: todaysHourlyResults[index].weather[0].icon, labelHour: String(currentHour + index) + ":00")
                        }
                    
                    }
                } else if whichDay == "Tomorrow" {

                  
                        ForEach(tomorrowsHourlyResults.indices, id: \.self) { index in
                            if index - hoursLastsToday <= 23 {
                        WeatherSquare(temp: tomorrowsHourlyResults[index].temp, main: tomorrowsHourlyResults[index].weather[0].main, icon: tomorrowsHourlyResults[index].weather[0].icon, labelHour: String(index-hoursLastsToday) + ":00" )
                        }
                    }

                }

            }.ignoresSafeArea(SafeAreaRegions.container, edges: .horizontal)

        }.frame(width: UIScreen.screenWidth, height: 120, alignment: .leading)
        .onAppear {
            DispatchQueue.main.async {
                print("It's finally loading")
            Api().getPosts(currCityCoord: currentCityCoord) { (result) in
                self.hourlyResults = result.hourly
                self.todaysHourlyResults = result.hourly[0..<hoursLastsToday]
                    self.tomorrowsHourlyResults = result.hourly[hoursLastsToday..<indexWhenTomorrowEnds]
                }
            }
        }
    }
}

struct WeatherScroll_Previews: PreviewProvider {
    static var previews: some View {
        WeatherScroll()
    }
}
