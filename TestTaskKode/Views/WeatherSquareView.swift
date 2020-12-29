//
//  WeatherSquare.swift
//  TestTaskKode
//
//  Created by Dmitrii on 06.11.2020.
//

import SwiftUI

struct WeatherSquare: View {
    var temp :Int
    var main :String
    var icon : String

    var body: some View {
        VStack(spacing: 0) {
            VStack {
                Image(icon)
                    .resizable()
//                        .colorInvert()

                    .frame(width: 80, height:80, alignment: .center)
            }.frame(width: 68, height: 68, alignment: .center)

            Text(String(temp)).font(Font.custom("SFProText-Heavy", size: 16))
                .frame(width: 42, height: 24, alignment: .center)
            Text(main).font(Font.custom("SFProText", size: 13))
                .frame(width: 80, height: 24, alignment: .center)

        }.padding(.bottom, 4)

        .frame(width: 80, height: 120, alignment: .center)
        .background(Color(UIColor(red: 1, green: 1, blue: 1, alpha: 0.16)))
        .foregroundColor(.white)
        .cornerRadius(10.0
        )

    }

}

struct WeatherSquare_Previews: PreviewProvider {
    static var previews: some View {
        Text("")
    }
}
