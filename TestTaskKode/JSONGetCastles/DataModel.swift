//
//  DataModel.swift
//  Music Search
//
//  Created by Alejandrina Patrón López on 1/18/21.
//

import Foundation

// https://itunes.apple.com/search?term=coldplay&entity=castle
// https://ru.wikipedia.org/w/api.php?action=query&prop=extracts%7Ccoordinates%7Cimages%7Cimageinfo%7Cinfo%7Cdescription%7Cmapdata&list=&meta=&titles=Вилла_Франка&formatversion=2&exsentences=10&exlimit=1&explaintext=1&format=json

class DataModel {
  
  private var dataTask: URLSessionDataTask?
  
  func loadcastles(searchTerm: String, completion: @escaping(([Castle]) -> Void)) {
    dataTask?.cancel()
    guard let url = buildUrl(forTerm: searchTerm) else {
      completion([])
      return
    }
    
    dataTask = URLSession.shared.dataTask(with: url) { data, _, _ in
      guard let data = data else {
        completion([])
        return
      }
      
      if let castleResponse = try? JSONDecoder().decode(CastleResponse.self, from: data) {
        completion(castleResponse.castles)
      }
    }
    dataTask?.resume()
  }
  
  private func buildUrl(forTerm searchTerm: String) -> URL? {
    guard !searchTerm.isEmpty else { return nil }
    
    let queryItems = [
      URLQueryItem(name: "term", value: searchTerm),
      URLQueryItem(name: "entity", value: "castle"),
    ]
    var components = URLComponents(string: "https://itunes.apple.com/search")
    components?.queryItems = queryItems
    
    return components?.url
  }
}

struct CastleResponse: Decodable {
  let castles: [Castle]
  
  enum CodingKeys: String, CodingKey {
    case castles = "results"
  }
}

struct Castle: Decodable {
//  let id: Int
//  let trackName: String
//  let artistName: String
//  let artworkUrl: String
//
//  enum CodingKeys: String, CodingKey {
//    case id = "trackId"
//    case trackName
//    case artistName
//    case artworkUrl = "artworkUrl60"
//  }
    
//   here is new names of entities model
    let id: Int
    let batchcomplete:String
    let contentmodel:String
    let coordinates: String
    let extract:String
    let images:String
    let lastrevid:String
    let length:String
    let mapdata:String
    let ns:String
    let pageid:String
    let pagelanguage:String
    let pagelanguagedir:String
    let pagelanguagehtmlcode:String
   
    let touched:String
    let trackName:String
//    let artworkUrl:String
//    let title:String
//    let artistName:String
    
      enum CodingKeys: String, CodingKey {
        case id = "trackId"
        case trackName = "title"
        case pagelanguage = "artistName"
        case  images = "artworkUrl"
        
        case batchcomplete
        case contentmodel
        case coordinates
        case extract
        case lastrevid
        case length
        case mapdata
        case ns
        case pageid
        case pagelanguagedir
        case pagelanguagehtmlcode
        case touched
//        case images
//        case pagelanguage
//        case title
      }
    
    
    
}
