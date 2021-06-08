//
//  DayLabelView.swift
//  TestTaskKode
//
//  Created by Dmitrii on 06.11.2020.
//

import SwiftUI

struct DayLabelViewToday: View {

    var body: some View {
        Text(returnCurrDate()).font(Font.custom("SFProText-Medium", size: 16))
            .foregroundColor(.black)
            .opacity(0.48)
            .padding(.top, 0)
            .padding(.bottom, 8)
            .frame(width: UIScreen.screenWidth - 48, height: 24, alignment: .leading)

    }
}

struct DayLabelViewTomorrow: View {

    var body: some View {
        Text(returnTomorrowDay()).font(Font.custom("SFProText-Medium", size: 16))
            .foregroundColor(.black)
            .opacity(0.48)
            .padding(.top, 0)
            .padding(.bottom, 8)
            .frame(width: UIScreen.screenWidth - 48, height: 24, alignment: .leading)

    }
}

struct DayLabelView_Previews: PreviewProvider {
    static var previews: some View {
        DayLabelViewToday()
    }
}
