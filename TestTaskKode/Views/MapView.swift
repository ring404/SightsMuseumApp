//
//  MapView.swift
//  TestTaskKode
//
//  Created by Dmitrii on 08.11.2020.
//

import SwiftUI
import MapKit

struct MapCity: View {
    var currentCityString: String

    var theCity: City
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(sortDescriptors: []) private var cities: FetchedResults<City>
    @State var filter: String = ""

    init(filter: String,  currentCityString: String, theCity: City) {
        self.theCity = City()
        self.currentCityString = currentCityString

        self.filter = currentCityString
        let ascendingNameSortDescriptor = NSSortDescriptor(keyPath: \City.name, ascending: true)
        let predicate: NSPredicate? = !filter.isEmpty ? NSPredicate(format: "name == %@", filter) : nil
        self._cities = FetchRequest(
            entity: City.entity(),
            sortDescriptors: [ascendingNameSortDescriptor],
            predicate: predicate,
            animation: .default)
        self.theCity = self.cities.first ?? City(context: viewContext)
    }

    @State var region = MKCoordinateRegion()

    var body: some View {

        Map(coordinateRegion: $region )
            .onAppear {
                region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: cities.first!.latitude, longitude: cities.first!.longitude), span: MKCoordinateSpan(latitudeDelta: 0.3, longitudeDelta: 0.3)) }

            .frame(width: UIScreen.screenWidth, height: UIScreen.screenWidth * 0.65)

    }

}

struct MapMuseum: View {
    var currentMuseumString: String

    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(sortDescriptors: []) private var cities: FetchedResults<City>
    @State var filter: String = ""
    @Binding var isShowingDetailView: Bool

    init(filter: String, isShowingDetailView: Binding<Bool>, currentMuseumString: String) {

        self.currentMuseumString = currentMuseumString

        self._isShowingDetailView = isShowingDetailView
        self.filter = currentMuseumString
        let ascendingNameSortDescriptor = NSSortDescriptor(keyPath: \City.name, ascending: true)
        let predicate: NSPredicate? = !filter.isEmpty ? NSPredicate(format: "name == %@", filter) : nil
        self._cities = FetchRequest(
            entity: City.entity(),
            sortDescriptors: [ascendingNameSortDescriptor],
            predicate: predicate,
            animation: .default)

    }

    @State var region = MKCoordinateRegion()

    var body: some View {

        Map(coordinateRegion: $region)
            .onAppear {
                region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: cities.first!.latitude, longitude: cities.first!.longitude), span: MKCoordinateSpan(latitudeDelta: 0.3, longitudeDelta: 0.3)) }

            .frame(width: UIScreen.screenWidth, height: UIScreen.screenWidth * 0.38)

    }

}
