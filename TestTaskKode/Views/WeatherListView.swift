//
//  PostList.swift
//  TestTaskKode
//
//  Created by Dmitrii on 08.11.2020.
//

import Foundation
import SwiftUI

struct WeatherList: View {
    @State var hourlyResults  = [Hourly]()

    var body: some View {
        VStack {

            ScrollView(.horizontal) {
                HStack {
                    ForEach(hourlyResults) {
                         result in
                        VStack {

                            WeatherSquare(temp: Int(result.temp), main: result.weather[0].main, icon: result.weather[0].icon)

                        }

                    }
                }

            }

            .onAppear {

                    print("It's finally loading")

                Api().getPosts { (result) in
                        self.hourlyResults = result.hourly
                    }
                }

        }.background(Color.blue.opacity(0.3))
    }
}

struct WeatherList_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            WeatherList()
        }
    }
}
