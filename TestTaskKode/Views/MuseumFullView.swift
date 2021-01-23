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
    @State var numbersOfLinestext = 5
    @State var moreInfoExpanded = false

    init(filter: String,  currentMuseumString: String) {

        self.currentMuseumString = currentMuseumString
        self.numbersOfLinestext = numbersOfLinestext
        self.moreInfoExpanded = moreInfoExpanded

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
//        var test = CGFloat(self.numbersOfLinestext / 5)
        ScrollView(.vertical) {
        VStack(alignment: .leading, spacing: .none) {
        Image(museums.first!.imageURL!)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: UIScreen.screenWidth , height: UIScreen.screenWidth * 0.7, alignment: .top)

            Text(museums.first!.nameMus!).font(.title)
//                .padding()
                .multilineTextAlignment(.center)
                .lineLimit(2)
//                .frame(width:  UIScreen.screenWidth ,  alignment: .center)
                .frame(width: UIScreen.screenWidth, height: UIScreen.screenWidth * 0.2, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            VStack(alignment: .trailing, spacing: .none) {
                Text(museums.first!.fullDesc!)
//                Text(String(format: "", numbersOfLinestext ?? "def"))
                    .lineLimit(self.numbersOfLinestext)
                    .multilineTextAlignment(.leading)
                    .frame(width: UIScreen.screenWidth, height: UIScreen.screenWidth * 0.3 * CGFloat(self.numbersOfLinestext / 5), alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
//                Text("check more info link").font(.footnote).foregroundColor(.blue).padding(.top, 2)
                                                if self.moreInfoExpanded {
                                                Text("click here to fold").font(.footnote).foregroundColor(.blue).padding(.top, 2)
                                                    .onTapGesture {
                                                        self.numbersOfLinestext = 5
                                                        self.moreInfoExpanded = false
                                                }
                 } else {
                                                    Text("click here to expand").font(.footnote).foregroundColor(.blue).padding(.top, 2)
                                                        .onTapGesture {
                                                            self.moreInfoExpanded = true
                                                            self.numbersOfLinestext = 15
                                                }
                                            }
            }
//            .padding()

            VStack(alignment: .leading, spacing: 0) {
                Text("On the Map").font(.title).padding()

                ZStack {

                    Map(coordinateRegion: $region)
                        .onAppear {
                            region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: museums.first!.latitudeMus, longitude: museums.first!.longitudeMus), span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)) }

                        .frame(width: UIScreen.screenWidth, height: UIScreen.screenWidth * 0.6)

                }
            } .frame(width:  UIScreen.screenWidth ,  alignment: .center)
        }
        .background(Color(UIColor(red: 0.118, green: 0.118, blue: 0.118, alpha: 1)))
        .foregroundColor(.white)
        .ignoresSafeArea(.container, edges: .bottom)
        }
    }
}

struct MuseumFullView_Previews: PreviewProvider {
    static var previews: some View {

        Text("q")

    }
}
