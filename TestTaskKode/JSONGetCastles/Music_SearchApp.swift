//
//  Music_SearchApp.swift
//  Music Search
//
//  Created by Alejandrina Patrón López on 1/18/21.
//

import SwiftUI

//commented out since tests been done
//@main
struct Music_SearchApp: App {
    var body: some Scene {
        WindowGroup {
          MusicSearchView(viewModel: castleListViewModel())
        }
    }
}
