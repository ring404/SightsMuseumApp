//
//  castleListViewModel.swift
//  Music Search
//
//  Created by Alejandrina Patrón López on 1/18/21.
//

import Combine
import Foundation
import SwiftUI

class castleListViewModel: ObservableObject {
  @Published var searchTerm: String = ""
  @Published public private(set) var castles: [CastleViewModel] = []
  
  private let dataModel: DataModel = DataModel()
  private let artworkLoader: ArtworkLoader = ArtworkLoader()
  private var disposables = Set<AnyCancellable>()
  
  init() {
    $searchTerm
      .sink(receiveValue: loadcastles(searchTerm:))
      .store(in: &disposables)
  }
  
  private func loadcastles(searchTerm: String) {
    castles.removeAll()
    artworkLoader.reset()
    
    dataModel.loadcastles(searchTerm: searchTerm) { castles in
      castles.forEach { self.appendcastle(castle: $0) }
    }
  }
  
  private func appendcastle(castle: CastleAtFull) {
    let castleViewModel = CastleViewModel(castle: castle)
    DispatchQueue.main.async {
      self.castles.append(castleViewModel)
    }
    
    artworkLoader.loadArtwork(forCastle: castle) { image in
      DispatchQueue.main.async {
        castleViewModel.artwork = image
      }
    }
  }
}

class CastleViewModel: Identifiable, ObservableObject {
  let id: Int
  let trackName: String
  let artistName: String
  @Published var artwork: Image?
  
  init(castle: CastleAtFull) {
    self.id = castle.id
//    self.trackName = castle.trackName
//    self.artistName = castle.artistName
    
    
    self.trackName = castle.trackName
    self.artistName = castle.extract
  }
}
