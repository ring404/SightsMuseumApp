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
        VStack {

        Map(coordinateRegion: $region )
            
            .onAppear {
                region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: cities.first!.latitude, longitude: cities.first!.longitude), span: MKCoordinateSpan(latitudeDelta: 0.3, longitudeDelta: 0.3)) }
            
            .frame(width: UIScreen.screenWidth, height: UIScreen.screenWidth * 0.65)
            
            
    }
       
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



struct RoundedCorners: Shape {
    var tl: CGFloat = 0.0
    var tr: CGFloat = 0.0
    var bl: CGFloat = 0.0
    var br: CGFloat = 0.0

    func path(in rect: CGRect) -> Path {
        var path = Path()

        let width = rect.size.width
        let height = rect.size.height

        // Make sure we do not exceed the size of the rectangle
        let tr = min(min(self.tr, height/2), width/2)
        let tl = min(min(self.tl, height/2), width/2)
        let bl = min(min(self.bl, height/2), width/2)
        let br = min(min(self.br, height/2), width/2)

        path.move(to: CGPoint(x: width / 2.0, y: 0))
        path.addLine(to: CGPoint(x: width - tr, y: 0))
        path.addArc(center: CGPoint(x: width - tr, y: tr), radius: tr,
                    startAngle: Angle(degrees: -90), endAngle: Angle(degrees: 0), clockwise: false)

        path.addLine(to: CGPoint(x: width, y: height - br))
        path.addArc(center: CGPoint(x: width - br, y: height - br), radius: br,
                    startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 90), clockwise: false)

        path.addLine(to: CGPoint(x: bl, y: height))
        path.addArc(center: CGPoint(x: bl, y: height - bl), radius: bl,
                    startAngle: Angle(degrees: 90), endAngle: Angle(degrees: 180), clockwise: false)

        path.addLine(to: CGPoint(x: 0, y: tl))
        path.addArc(center: CGPoint(x: tl, y: tl), radius: tl,
                    startAngle: Angle(degrees: 180), endAngle: Angle(degrees: 270), clockwise: false)

        return path
    }
}
