//
//  MuseumCard.swift
//  TestTaskKode
//
//  Created by Dmitrii on 07.11.2020.
//

import SwiftUI

struct MuseumCard: View {
    @State private var activateLink: Bool = false

    var currentCityString:String
    var currentMuseumString: String

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
                    NavigationLink(destination: MuseumFullDescScreen(currMuseum:item.nameMus!), isActive: $activateLink) {

                    }.frame(width: 0, height: 0, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)

                    Text(item.nameMus!)
                        .offset(x: 0, y: 50)

                        .font(Font.custom("SFProDisplay-Bold", size: 18))
                        .foregroundColor(.white)

                }

            }
            VStack {
                Text(item.shortDesc!)
//                    .minimumScaleFactor(0.5)
                        .lineLimit(3)
                        .multilineTextAlignment(.leading)
                    .font(Font.custom("SFProDisplay", size: 16))
                    .padding()

                    .frame(width: UIScreen.screenWidth * 0.95, height: UIScreen.screenWidth * 0.28
                           , alignment: .center)
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
