////
////  WikiJsonAPI.swift
////  TestTaskKode
////
////  Created by Dmitrii on 15.02.2021.
////
//
//import Foundation
//import SwiftUI
//
//struct TextListWithJsonCastles: View {
//    let decoder = JSONDecoder()
//    var person: LoginUserResponse
//    var people:LoginUserResponse
//
//    
//    
//    
//    init() {
//        let peterson = LoginUserResponse(from: decoder)
//        self.person = peterson
//        self.people = peterson
//    }
//    
//    var body: some View {
////        var funcIsReturn =
//       
////       Text(String(containedView()))
//        Text("\(self.person.age) is so so aged \(self.person.name) ")
////        "\(age) times 2.5 "
////        var persons = containedView()
////        person.age = self.containedView().
////            person.name
//         
//        
//         
//    
// 
//     }
//    mutating func containedView() -> ([Person]) {
//        
//        let jsonString = """
//        [
//            {
//                "name": "Taylor Swift",
//                "age": 26
//            },
//            {
//                "name": "Justin Bieber",
//                "age": 25
//            }
//        ]
//        """
//
////        let str = "{\"result\":\"success\",\"data\":{\"userId\":\"10\",\"name\":\"Foo\"},\"mess\"
//        let jsonData = Data(jsonString.utf8)
//        do {
//            let people = try decoder.decode([Person].self, from: jsonData)
//            print(people)
//            return people
//        } catch {
//            print(error.localizedDescription)
////            here below suppose to be
////            let people of type Person
////            with person.name = "Stupid" and person.age = 00
//            let people = try? decoder.decode([Person].self, from: jsonString.data(using: .utf8)!)
//            return people!
//        }
//        
//       
//    }
//}
//
//
//struct JsonCodableToSwift {
//  
//    
//}
//
////struct Person: Codable {
////    var name: String
////    var age: Int
////
////
////    private enum CodingKeys: String, CodingKey {
////            case name, age
////        }
////
////    init(from decoder: Decoder) throws
////        {
////            let values = try decoder.container(keyedBy: CodingKeys.self)
////            name = try values.decode(String.self, forKey: .name)
////        age  = try values.decode(Int.self, forKey: .age)
//////            mess = try values.decode([String].self, forKey: .mess)
//////            if let d = try? values.decode(LoginUserResponseData.self, forKey: .data) {
//////                data = d
//////            }
////        }
////}
//
//
//
//
//class LoginUserResponse : Codable {
//    var result: String = ""
//    var data: Person?
//    var mess: [String] = []
//
//    private enum CodingKeys: String, CodingKey {
//        case result, data, mess
//    }
//
//    required init(from decoder: Decoder) throws {
//        
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//                result = try values.decode(String.self, forKey: .result)
//                mess = try values.decode([String].self, forKey: .mess)
//                data = try? values.decode(Person.self, forKey: .data)
//      //            name = try values.decode(String.self, forKey: .name)
//      //        age  = try values.decode(Int.self, forKey: .age)
////        let values = try decoder.container(keyedBy: CodingKeys.self)
////        result = try values.decode(String.self, forKey: .result)
////        mess = try values.decode([String].self, forKey: .mess)
////        data = try? values.decode(Person.self, forKey: .data)
//    }
//}
//
//public struct Person : Codable {
//    var age = "0"
//    var name = "Stiupid"
//}
