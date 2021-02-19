//
//  ArtworkLoader.swift
//  Music Search
//
//  Created by Alejandrina Patrón López on 1/18/21.
//

import Foundation
import SwiftUI

class ArtworkLoader {
  private var dataTasks: [URLSessionDataTask] = []
//    Image(systemName: "chevron.backward").frame(width: 25, height: 30)
  func loadArtwork(forCastle castle: Castle, completion: @escaping((Image?) -> Void)) {
    guard let imageUrl = URL(string: "https://ru.wikipedia.org/wiki/Заглавная_страница") else {
//        here I replace code with the placeholder
    //    guard let imageUrl = URL(string: castle.artworkUrl) else {
      completion(nil)
      return
    }
    
//     /Users/qqrr/Downloads/KodeTestTask/TestTaskKode/JSONGetCastles/ArtworkLoader.swift:15:45: Value of type 'Castle' has no member 'artworkUrl'
    
    let dataTask = URLSession.shared.dataTask(with: imageUrl) { data, _, _ in
      guard let data = data, let artwork = UIImage(data: data) else {
        completion(nil)
        return
      }
      
      let image = Image(uiImage: artwork)
      completion(image)
    }
    dataTasks.append(dataTask)
    dataTask.resume()
  }

  func reset() {
    dataTasks.forEach { $0.cancel() }
    dataTasks.removeAll()
  }
}
