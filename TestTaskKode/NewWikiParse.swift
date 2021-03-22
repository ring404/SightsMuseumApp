//
//  NewWikiParse.swift
//  TestTaskKode
//
//  Created by Dmitrii on 22.03.2021.
//

import Foundation

struct WikiData: Codable {
    var batchcomplete: String
    var query: Query
}

struct Query: Codable {
    var normalized: [[String: String]]
    var pageids: [String]
    var pages: [Int: PageData]
}

struct PageData: Codable {
    var pageid: Int
    var ns: Int
    var title: String
    var extract: String
    var thumbnail: Thumbnail
    var pageimage: String
    var coordinates: [Coordinate]
}

struct Coordinate:Codable {
    var lat:Double
    var lon:Double
}

struct Thumbnail: Codable {
    var source: String
    var width: Int
    var height: Int
}


struct GetWikiAPI {
    
    
    func getPageIdFromName(query: String) -> String {
        
        
        
        let cuttedStringForTest = "https://en.wikipedia.org/w/api.php?action=query&format=json&prop=extracts%7Cpageimages%7Ccoordinates&indexpageids=1&titles=\(query)&redirects=1&exintro=1&explaintext=1&pithumbsize=500"
        
//     here is new url    https://en.wikipedia.org/w/api.php?action=query&format=json&prop=extracts%7Cpageimages%7Ccoordinates&indexpageids=1&titles=Rossgarten_Gate&redirects=1&exintro=1&explaintext=1&pithumbsize=500
        
//        here is old working URL:
//        https://en.wikipedia.org/w/api.php?format=json&action=query&prop=extracts%7Cpageimages&exintro=&explaintext=&titles=\(query)&indexpageids=&redirects=1&pithumbsize=500"
        

        
        let url = URL(string: cuttedStringForTest)!
        let jsonData = try! Data(contentsOf: url)
//        let datastring = String(data: jsonData, encoding: .utf8)
        let decoder = JSONDecoder()
        do {
            // Decode data to object
            let object = try decoder.decode(WikiData.self, from: jsonData)
           
            
            var parsedMuseum: [String: String] = ["place": "Калининград", "nameMus": object.query.pages.first!.value.title, "imageURL": object.query.pages.first!.value.thumbnail.source ,
                                                  "shortDesc": String(object.query.pages.first!.value.extract.prefix(100)) , "fullDesc": object.query.pages.first!.value.extract ,
                                                  "latitudeMus": String(object.query.pages.first!.value.coordinates.first!.lat), "longitudeMus": String(object.query.pages.first!.value.coordinates.first!.lon)]
            
            
    
            return object.query.pageids[0]
        }
        catch {
            print(error)
            return "oshibka"
        }
        
    }
    

}


struct GetMuseumFromWiki {
    
    
    func getPage(query: String) -> [String: String]  {

        let cuttedStringForTest = "https://en.wikipedia.org/w/api.php?action=query&format=json&prop=extracts%7Cpageimages%7Ccoordinates&indexpageids=1&titles=\(query)&redirects=1&exintro=1&explaintext=1&pithumbsize=500"
        
//     here is new url    https://en.wikipedia.org/w/api.php?action=query&format=json&prop=extracts%7Cpageimages%7Ccoordinates&indexpageids=1&titles=Rossgarten_Gate&redirects=1&exintro=1&explaintext=1&pithumbsize=500
        
//        here is old working URL:
//        https://en.wikipedia.org/w/api.php?format=json&action=query&prop=extracts%7Cpageimages&exintro=&explaintext=&titles=\(query)&indexpageids=&redirects=1&pithumbsize=500"
        

        
        let url = URL(string: cuttedStringForTest)!
        let jsonData = try! Data(contentsOf: url)
        let decoder = JSONDecoder()
        do {
            // Decode data to object
            let object = try decoder.decode(WikiData.self, from: jsonData)
           
            
            var parsedMuseum: [String: String] = ["place": "Калининград", "nameMus": object.query.pages.first!.value.title, "imageURL": object.query.pages.first!.value.thumbnail.source ,
                                                  "shortDesc": String(object.query.pages.first!.value.extract.prefix(100)) , "fullDesc": object.query.pages.first!.value.extract ,
                                                  "latitudeMus": String(object.query.pages.first!.value.coordinates.first!.lat), "longitudeMus": String(object.query.pages.first!.value.coordinates.first!.lon)]
            
            
    
            return parsedMuseum
        }
        catch {
            print(error)
  
            return ["place":"error"]
        }
        
    }
    

}
