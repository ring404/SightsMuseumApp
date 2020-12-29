//
//  MuseumFullView.swift
//  TestTaskKode
//
//  Created by Dmitrii on 08.11.2020.
//

import SwiftUI
import CoreData
import MapKit

struct MuseumFullView: View {

    @State private var activateLink: Bool = false

    var currentMuseumString: String

    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(sortDescriptors: []) private var museums: FetchedResults<Museums>
    @State var filter: String = ""

    init(filter: String,  currentMuseumString: String) {

        self.currentMuseumString = currentMuseumString

        self.filter = filter
        let ascendingNameSortDescriptor = NSSortDescriptor(keyPath: \Museums.nameMus, ascending: true)
        let predicate: NSPredicate? = !filter.isEmpty ? NSPredicate(format: "nameMus BEGINSWITH[c] %@", filter) : nil
        self._museums = FetchRequest(
            entity: Museums.entity(),
            sortDescriptors: [ascendingNameSortDescriptor],
            predicate: predicate,
            animation: .default)

    }

    @State var region = MKCoordinateRegion()

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
        Image(museums.first!.imageURL!)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: UIScreen.screenWidth , height: UIScreen.screenWidth * 0.53, alignment: .top)

            Text(museums.first!.nameMus!).font(.largeTitle)
//                .padding()

            VStack(alignment: .leading, spacing: 0) {
                Text(museums.first!.fullDesc!)
                    .lineLimit(3)
                    .multilineTextAlignment(.leading)
                Text("check more info link").font(.footnote).foregroundColor(.blue).padding(.top, 2)

            }.padding()

            VStack(alignment: .leading, spacing: 0) {
                Text("On the Map").font(.title).padding()

                ZStack {

                    Map(coordinateRegion: $region)
                        .onAppear {
                            region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: museums.first!.latitudeMus, longitude: museums.first!.longitudeMus), span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)) }

                        .frame(width: UIScreen.screenWidth, height: UIScreen.screenWidth * 0.5)

                }
            } .frame(width:  UIScreen.screenWidth ,  alignment: .center)
        }
        .background(Color(UIColor(red: 0.118, green: 0.118, blue: 0.118, alpha: 1)))
        .foregroundColor(.white)
        .ignoresSafeArea(.container, edges: .bottom)
    }
}

struct MuseumFullView_Previews: PreviewProvider {
    static var previews: some View {

        Text("q")

    }
}
