//
//  CurrentCityView.swift
//  TestTaskKode
//
//  Created by Dmitrii on 06.11.2020.
//

import SwiftUI

struct CurrentCityView: View {
    var currentCityString:String
    var body: some View {

        Text(currentCityString).font(Font.custom("SFProText-Heavy", size: 32))
            .colorInvert()
            .padding(.top, 16)
            .padding(.bottom, 8)
            .frame(width: UIScreen.screenWidth - 48, height: 48, alignment: .leading)
    }
}

struct CurrentCityView_Previews: PreviewProvider {
    static var previews: some View {
        CurrentCityView(currentCityString:"Default city")
    }
}
