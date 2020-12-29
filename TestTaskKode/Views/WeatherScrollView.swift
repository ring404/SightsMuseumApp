//
//  WeatherScroll.swift
//  TestTaskKode
//
//  Created by Dmitrii on 06.11.2020.
//

import SwiftUI

struct WeatherScroll: View {

    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                Rectangle()
                    .foregroundColor(Color(UIColor(red: 0.118, green: 0.118, blue: 0.118, alpha: 1)))
                    .frame(width: 18, alignment: .leading)
//                WeatherSquare()
//                WeatherSquare()
//                WeatherSquare()
//                WeatherSquare()
//                WeatherSquare()
            }.ignoresSafeArea(SafeAreaRegions.container, edges: .horizontal)

        }.frame(width: UIScreen.screenWidth, height: 120, alignment: .leading)
    }
}

struct WeatherScrollArr: View {
//    var weatherArray =  Api().getPosts(completion: [Hourly]())
//    var weatherMain = weatherArray.weather[0].main
    @State var hourlyResults  = [Hourly]()
    @State var todaysHourlyResults = ArraySlice<Hourly>()
    @State var tomorrowsHourlyResults = ArraySlice<Hourly>()
    var whichDay :String

    var body: some View {

        ScrollView(.horizontal) {
            HStack {
                if whichDay == "Today" {
                ForEach(todaysHourlyResults) { result in

                    WeatherSquare(temp: Int(result.temp), main: result.weather[0].main, icon: result.weather[0].icon)

                }
                } else if whichDay == "Tomorrow" {

                    ForEach(tomorrowsHourlyResults) { result in

                        WeatherSquare(temp: Int(result.temp), main: result.weather[0].main, icon: result.weather[0].icon )

                    }

                }

            }.ignoresSafeArea(SafeAreaRegions.container, edges: .horizontal)

        }.frame(width: UIScreen.screenWidth, height: 120, alignment: .leading)
        .onAppear {

                print("It's finally loading")
                //ApiTest().getPostsTest()
                Api().getPosts { (result) in
                    self.hourlyResults = result.hourly
                    self.todaysHourlyResults = result.hourly[0..<24]
                    self.tomorrowsHourlyResults = result.hourly[24..<self.hourlyResults.count]
                }
            }
    }
}

struct WeatherScroll_Previews: PreviewProvider {
    static var previews: some View {
        WeatherScroll()
    }
}
