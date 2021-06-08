//
//  Persistence.swift
//  TestTaskKode
//
//  Created by Dmitrii on 05.11.2020.
//

import CoreData

struct PersistenceController {

    static let shared = PersistenceController()

    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        for num in 0..<5 {
            let newItem = City(context: viewContext)
            newItem.name = citiesArr[num]
            newItem.latitude = latitudeArr[num]
            newItem.longitude = longArr[num]
        }
        let museumFromWikiAPI = GetMuseumFromWiki.init()
        let oneMuseumFromCoreData = museumFromWikiAPI.getPage(query: "Rossgarten_Gate")
        let secondMuseumFromCoreData = museumFromWikiAPI.getPage(query: "Brandenburg_Gate_(Kaliningrad)")
       let  newItemFirstMuseum = Museums(context: viewContext)
        
        newItemFirstMuseum.city = oneMuseumFromCoreData["city"]
        newItemFirstMuseum.shortDesc = oneMuseumFromCoreData["shortDesc"]
        newItemFirstMuseum.imageURL = oneMuseumFromCoreData["imageURL"]
        newItemFirstMuseum.latitudeMus = Double(oneMuseumFromCoreData["latitudeMus"]!)!
        newItemFirstMuseum.longitudeMus = Double(oneMuseumFromCoreData["longitudeMus"]!)!
        newItemFirstMuseum.nameMus = oneMuseumFromCoreData["nameMus"]
        newItemFirstMuseum.fullDesc = oneMuseumFromCoreData["fullDesc"]
        
        
        let  newItemSecondMuseum = Museums(context: viewContext)
               newItemSecondMuseum.city = secondMuseumFromCoreData["city"]
               newItemSecondMuseum.shortDesc = secondMuseumFromCoreData["shortDesc"]
               newItemSecondMuseum.imageURL = secondMuseumFromCoreData["imageURL"]
               newItemSecondMuseum.latitudeMus = Double(secondMuseumFromCoreData["latitudeMus"]!)!
               newItemSecondMuseum.longitudeMus = Double(secondMuseumFromCoreData["longitudeMus"]!)!
               newItemSecondMuseum.nameMus = secondMuseumFromCoreData["nameMus"]
               newItemSecondMuseum.fullDesc = secondMuseumFromCoreData["fullDesc"]
        

//        let  newItemSecondMuseum = Museums(context: viewContext)
//        newItemSecondMuseum.city = secondMuseum["city"]
//        newItemSecondMuseum.shortDesc = secondMuseum["shortDesc"]
//        newItemSecondMuseum.imageURL = secondMuseum["imageURL"]
//        newItemSecondMuseum.latitudeMus = Double(secondMuseum["latitudeMus"]!)!
//        newItemSecondMuseum.longitudeMus = Double(secondMuseum["longitudeMus"]!)!
//        newItemSecondMuseum.nameMus = secondMuseum["nameMus"]
//        newItemSecondMuseum.fullDesc = secondMuseum["fullDesc"]

//        do {
//            try viewContext.save()
//        } catch {
//            // Replace this implementation with code to handle the error appropriately.
//            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//            let nsError = error as NSError
//            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
//        }
        return result
    }()

    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "TestTaskKode")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (_, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.

                /*
                Typical reasons for an error here include:
                * The parent directory does not exist, cannot be created, or disallows writing.
                * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                * The device is out of space.
                * The store could not be migrated to the current model version.
                Check the error message to determine what the actual problem was.
                */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }

        })

        
//        here is bad mistake -- one fetch for two dirrerent entities
        let fetch : NSFetchRequest<City> = City.fetchRequest()
//        let cityFetch : NSFetchRequest<City> = City.fetchRequest()
//        let museumFetch : NSFetchRequest<Museums> = Museums.fetchRequest()

                let viewContext = container.viewContext
            let allRecords =  try?  viewContext.fetch(fetch)
        if ((allRecords?.isEmpty) != nil) {
                for num in 0..<5 {
                    let newItem = City(context: viewContext)
                    newItem.name = citiesArr[num]
                    newItem.latitude = latitudeArr[num]
                    newItem.longitude = longArr[num]
                }
            let museumFromWikiAPI = GetMuseumFromWiki.init()
            let oneMuseumFromCoreData = museumFromWikiAPI.getPage(query: "Rossgarten_Gate")
            let secondMuseumFromCoreData = museumFromWikiAPI.getPage(query: "Brandenburg_Gate_(Kaliningrad)")
            let thirdMuseumFromCoreData = museumFromWikiAPI.getPage(query: "King%27s_Gate_(Kaliningrad)")
            let fourthMuseumFromCoreData = museumFromWikiAPI.getPage(query: "Sackheim_Gate")
            
            
               let  newItemFirstMuseum = Museums(context: viewContext)
                newItemFirstMuseum.city = oneMuseumFromCoreData["place"]
                newItemFirstMuseum.shortDesc = oneMuseumFromCoreData["shortDesc"]
                newItemFirstMuseum.imageURL = oneMuseumFromCoreData["imageURL"]
                newItemFirstMuseum.latitudeMus = Double(oneMuseumFromCoreData["latitudeMus"]!)!
                newItemFirstMuseum.longitudeMus = Double(oneMuseumFromCoreData["longitudeMus"]!)!
                newItemFirstMuseum.nameMus = oneMuseumFromCoreData["nameMus"]
                newItemFirstMuseum.fullDesc = oneMuseumFromCoreData["fullDesc"]

                let  newItemSecondMuseum = Museums(context: viewContext)
                newItemSecondMuseum.city = secondMuseumFromCoreData["place"]
                newItemSecondMuseum.shortDesc = secondMuseumFromCoreData["shortDesc"]
                newItemSecondMuseum.imageURL = secondMuseumFromCoreData["imageURL"]
                newItemSecondMuseum.latitudeMus = Double(secondMuseumFromCoreData["latitudeMus"]!)!
                newItemSecondMuseum.longitudeMus = Double(secondMuseumFromCoreData["longitudeMus"]!)!
                newItemSecondMuseum.nameMus = secondMuseumFromCoreData["nameMus"]
                newItemSecondMuseum.fullDesc = secondMuseumFromCoreData["fullDesc"]

                let  newItemThirdMuseum = Museums(context: viewContext)
                newItemThirdMuseum.city = thirdMuseumFromCoreData["place"]
                newItemThirdMuseum.shortDesc = thirdMuseumFromCoreData["shortDesc"]
                newItemThirdMuseum.imageURL = thirdMuseumFromCoreData["imageURL"]
                newItemThirdMuseum.latitudeMus = Double(thirdMuseumFromCoreData["latitudeMus"]!)!
                newItemThirdMuseum.longitudeMus = Double(thirdMuseumFromCoreData["longitudeMus"]!)!
                newItemThirdMuseum.nameMus = thirdMuseumFromCoreData["nameMus"]
                newItemThirdMuseum.fullDesc = thirdMuseumFromCoreData["fullDesc"]

                let  newItemFourthMuseum = Museums(context: viewContext)
                newItemFourthMuseum.city = fourthMuseumFromCoreData["place"]
                newItemFourthMuseum.shortDesc = fourthMuseumFromCoreData["shortDesc"]
                newItemFourthMuseum.imageURL = fourthMuseumFromCoreData["imageURL"]
                newItemFourthMuseum.latitudeMus = Double(fourthMuseumFromCoreData["latitudeMus"]!)!
                newItemFourthMuseum.longitudeMus = Double(fourthMuseumFromCoreData["longitudeMus"]!)!
                newItemFourthMuseum.nameMus = fourthMuseumFromCoreData["nameMus"]
                newItemFourthMuseum.fullDesc = fourthMuseumFromCoreData["fullDesc"]

            }

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }

        }
    }
