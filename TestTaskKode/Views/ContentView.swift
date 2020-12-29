//
//  ContentView.swift
//  TestTaskKode
//
//  Created by Dmitrii on 05.11.2020.
//

import SwiftUI
import CoreData
import MapKit
import Foundation
import UIKit

//
//
//
//
//                  DISCLAIMER

// я понимаю что у меня здесь многие вещи написаны неидеально (форс анврапы и прочее что никогда бы не использовал в продакшене)
// но я уже не успеваю по дедлайну, чтобы привести всё в порядок
// так чтоу, не обессудьте

// p.s да, это SwiftUI
//
//
//
//

struct ContentView: View {

    var body: some View {

        SearchBarView()

    }

}

struct WeatherInCityScreen: View {
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    var currentCityString: String

    init(currentCityString: String) {
        self.currentCityString = currentCityString
    }

    @State private var activateLink: Bool = false
    var body: some View {

        VStack {

            MapCity(filter: currentCityString, currentCityString: currentCityString, theCity: City())

                .navigationBarBackButtonHidden(true)
                .navigationBarItems(leading: Button(action: {
                        self.mode.wrappedValue.dismiss()
                }) {
                        Image(systemName: "chevron.backward")
                    })
        }
            .background(Color(UIColor(red: 0.118, green: 0.118, blue: 0.118, alpha: 1)))
            .ignoresSafeArea(.container, edges: .bottom)
            .colorInvert()

            CurrentCityView(currentCityString: currentCityString)
                .colorInvert()
            DayLabelViewToday()
                .colorInvert()
            WeatherScrollArr(whichDay: "Today")
                .background(Color(UIColor(red: 0.118, green: 0.118, blue: 0.118, alpha: 1)))
                .ignoresSafeArea(.container, edges: .bottom)
                .colorInvert()

            DayLabelViewTomorrow()
                .colorInvert()
            WeatherScrollArr(whichDay: "Tomorrow")

            .background(Color(UIColor(red: 0.118, green: 0.118, blue: 0.118, alpha: 1)))
            .ignoresSafeArea(.container, edges: .bottom)
            .colorInvert()

            NavigationLink(destination: MuseumsListScreen(currentCityString: currentCityString), isActive: $activateLink) {
                if currentCityString == "Париж" {
                    Button("Достопримечательности", action: { self.activateLink = true })
                        .foregroundColor(.white)
                        .frame(width: UIScreen.screenWidth - 18, height: UIScreen.screenWidth * 0.1645, alignment: .center)
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                if currentCityString == "Нью-Йорк" {
                    Button("Достопримечательности", action: { self.activateLink = true })
                        .foregroundColor(.white)
                        .frame(width: UIScreen.screenWidth - 18, height: UIScreen.screenWidth * 0.1645, alignment: .center)
                        .background(Color.blue)
                        .cornerRadius(10)
                }

            }.navigationBarTitle("Погода в городе")

            Spacer()

    }

}

struct MuseumsListScreen: View {
    var currentCityString: String
    @State private var activateLink: Bool = false
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>

    var body: some View {

        VStack(alignment: .leading, spacing: 0) {

            MuseumCard(filter: currentCityString, currentMuseumString: currentCityString, currentCityString: currentCityString)

                .navigationBarBackButtonHidden(true)
                .navigationBarTitle("Достопримечательности")
                .navigationBarItems(leading: Button(action: {
                        self.mode.wrappedValue.dismiss()
                }) {
                        Image(systemName: "chevron.backward")
                    })

        }.padding(.horizontal, 50)
            .background(Color(UIColor(red: 0.118, green: 0.118, blue: 0.118, alpha: 1)))
            .colorInvert()
            .ignoresSafeArea(.container, edges: .bottom)

    }
}

struct MuseumFullDescScreen: View {
    @State private var activateLink: Bool = false
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    var currMuseum: String

    var body: some View {

        MuseumFullView(filter: currMuseum, currentMuseumString: currMuseum).colorInvert()

            .navigationBarBackButtonHidden(true)
            .navigationBarTitle("Достопримечательность")
            .navigationBarItems(leading: Button(action: {
                    self.mode.wrappedValue.dismiss()
            }) {
                    Image(systemName: "chevron.backward")
                })

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
            .environment(\.colorScheme, .dark)
        MuseumsListScreen(currentCityString: "Калининград")

    }
}

extension UIScreen {
    static let screenWidth = UIScreen.main.bounds.size.width
    static let screenHeight = UIScreen.main.bounds.size.height
    static let screenSize = UIScreen.main.bounds.size
}

func returnCurrDate(tomorrow: Bool = false) -> String {

    let date = Date()
    let todayCalendar = Calendar.current
    let day = todayCalendar.component(.day, from: date)
    let month = todayCalendar.component(.month, from: date)
    let year = todayCalendar.component(.year, from: date)
    let monthName = DateFormatter().monthSymbols[month - 1].prefix(3)

    return "Сегодня, \(day) \(monthName) \(year)"
}

func returnTomorrowDay() -> String {

    let currentDate = Date()
    var dateComponent = DateComponents()
    dateComponent.day = 1
    let futureDate = Calendar.current.date(byAdding: dateComponent, to: currentDate)

    let todayCalendar = Calendar.current
    let day = todayCalendar.component(.day, from: futureDate!)
    let month = todayCalendar.component(.month, from: futureDate!)
    let year = todayCalendar.component(.year, from: futureDate!)
    let monthName = DateFormatter().monthSymbols[month - 1].prefix(3)

    return "Завтра, \(day) \(monthName) \(year)"

}