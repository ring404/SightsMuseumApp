//
//  SearchBarView.swift
//  TestTaskKode
//
//  Created by Dmitrii on 09.11.2020.
//

import SwiftUI

struct SearchBarView: View {

   var citiesArrSearch = ["Нью-Йорк","Париж","Калининград", "Москва","Гурьевск"]
    var latitudeArr: [Double] = [40.6971494,48.8588377,54.7115288,55.5807481,54.7805993]
    var longArr: [Double] = [-74.2598636,2.2770204,20.3244485,36.8251361,20.597617]
    var lowerCasedcitiesArrSearch = [String]()
    init() {
//        let lowerCasedcitiesArrSearch = citiesArrSearch.toLowerCase()
        for word in citiesArrSearch {
//            lowerCasedcitiesArrSearch.append  =  word.lowercased()
            lowerCasedcitiesArrSearch.append(word.lowercased())
            }
    }
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)

    @State private var searchText = ""
    @State private var showCancelButton: Bool = false
    
    var body: some View {

        NavigationView {
            VStack {
                // Search view
                HStack {
                    HStack {
                        Image(systemName: "magnifyingglass")

                        TextField("поиск", text: $searchText, onEditingChanged: { _ in
                            self.showCancelButton = true
                        }, onCommit: {
                            print("onCommit")
                        })
                        .foregroundColor(.primary)

                        Button(action: {
                            self.searchText = ""
                        }) {
                            Image(systemName: "xmark.circle.fill").opacity(searchText == "" ? 0 : 1)
                        }
                    }
                    .padding(EdgeInsets(top: 8, leading: 6, bottom: 8, trailing: 6))
                    .foregroundColor(.secondary)
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(10.0)

                    if showCancelButton {

                        Button("Cancel") {
                                UIApplication.shared.endEditing(true)
                                self.searchText = ""
                                self.showCancelButton = false
                            print(paths)
                        }
                        .foregroundColor(Color(.systemBlue))
                    }
                }

                .padding(.horizontal)
                .navigationBarHidden(true)
                List {

                    ForEach(citiesArrSearch.filter {$0.hasPrefixIgnoringCase(searchText) || searchText == ""}, id:\.self) {
                        searchText in
                        NavigationLink(
//                            !! nafiga ego tuda peredavat'
                            destination: WeatherInCityScreen(currentCityString: searchText, currentCityLat: latitudeArr[citiesArrSearch.firstIndex(of: searchText) ?? 0], currentCityLon:  longArr[citiesArrSearch.firstIndex(of: searchText) ?? 0]),
                            label: {
                                Text(searchText)

                            })

                    }
                }
                .navigationBarTitle(Text("Погода"))

                .resignKeyboardOnDragGesture()
            } //vstack
        } // nav view
//        .colorInvert()
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct SearchBarView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SearchBarView()
                      .environment(\.colorScheme, .light)

            SearchBarView()
                      .environment(\.colorScheme, .dark)
                }
    }
}
extension UIApplication {
    func endEditing(_ force: Bool) {
        self.windows
            .filter {$0.isKeyWindow}
            .first?
            .endEditing(force)
    }
}

struct ResignKeyboardOnDragGesture: ViewModifier {
    var gesture = DragGesture().onChanged {_ in
        UIApplication.shared.endEditing(true)
    }
    func body(content: Content) -> some View {
        content.gesture(gesture)
    }
}

extension View {
    func resignKeyboardOnDragGesture() -> some View {
        return modifier(ResignKeyboardOnDragGesture())
    }
}

extension String {
     func hasPrefixIgnoringCase(_ prefix: String) -> Bool {
        range(of: prefix, options: [.anchored, .caseInsensitive]) != nil
    }
}
