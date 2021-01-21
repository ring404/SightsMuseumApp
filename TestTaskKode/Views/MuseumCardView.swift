//
//  MuseumCard.swift
//  TestTaskKode
//
//  Created by Dmitrii on 07.11.2020.
//

import SwiftUI

public class FetchMuseums {
    var currentCityString: String

    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(sortDescriptors: []) public var museumsFetched: FetchedResults<Museums>
    @State var filter: String = ""

    init(filter: String,  currentMuseumString: String) {

        self.currentCityString = currentMuseumString

        self.filter = filter
        let ascendingNameSortDescriptor = NSSortDescriptor(keyPath: \Museums.city, ascending: true)
        let predicate: NSPredicate? = !filter.isEmpty ? NSPredicate(format: "city BEGINSWITH[c] %@", filter) : nil
        self._museumsFetched = FetchRequest(
            entity: Museums.entity(),
            sortDescriptors: [ascendingNameSortDescriptor],
            predicate: predicate,
            animation: .default)

    }
}

struct MuseumCard: View {
    @State private var activateLink: Bool = false
    //    test
    //
//    var currentCityString:String
//    var currentMuseumString: String
    var currentCityString = "Париж"
    var currentMuseumString = "Центр Помпиду"
//

    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(sortDescriptors: []) private var museums: FetchedResults<Museums>
    @State var filter: String = ""

    init(filter: String,  currentMuseumString: String, currentCityString:String) {

        self.currentMuseumString = currentMuseumString
        self.currentCityString = currentCityString

        self.filter = filter
        let ascendingNameSortDescriptor = NSSortDescriptor(keyPath: \Museums.nameMus, ascending: true)
        let predicate: NSPredicate? = !filter.isEmpty ? NSPredicate(format: "city == %@", filter) : nil
        self._museums = FetchRequest(
            entity: Museums.entity(),
            sortDescriptors: [ascendingNameSortDescriptor],
            predicate: predicate,
            animation: .default)

    }

    var body: some View {

    ForEach(museums) { item in

       VStack(spacing: 0) {

            VStack {

                ZStack {

                    Image(item.imageURL!)
                        .frame(width: UIScreen.screenWidth * 0.95, height: UIScreen.screenWidth * 0.34, alignment: .center)

                     Rectangle().frame(width: UIScreen.screenWidth * 0.95, height: UIScreen.screenWidth * 0.34, alignment: .center)

                        .foregroundColor(.clear)
                        .background(LinearGradient(gradient: Gradient(colors: [.clear, .black]), startPoint: .top, endPoint: .bottom))
                    NavigationLink(destination: MuseumFullDescScreen(currMuseum:item.nameMus!, currentCityString: item.city!),  isActive: $activateLink) {

                    }.frame(width: 0, height: 0, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)

                    Text(item.nameMus!)
                        .offset(x: 0, y:35)

                        .font(Font.custom("SFProDisplay-Bold", size: 18))
                        .foregroundColor(.white)

                }

            }
            VStack {
                Text(item.shortDesc!)
//                    .minimumScaleFactor(0.5)
                        .lineLimit(5)
                        .multilineTextAlignment(.leading)
                    .font(Font.custom("SFProDisplay", size: 15))
                    .padding()

                    .frame(width: UIScreen.screenWidth * 0.95, height: UIScreen.screenWidth * 0.28, alignment: .center)
                    .foregroundColor(.white)
            }.background(Color.black)

        }.onTapGesture {

            activateLink = true

            print("tapped")
        }
        .cornerRadius(12)

        }

    }

}

struct MuseumCard_Previews: PreviewProvider {
    static var previews: some View {
        MuseumCard(filter: "Париж", currentMuseumString: "Париж", currentCityString: "Париж")
    }
}
