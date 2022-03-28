//
//  Persistence.swift
//  Shared
//
//  Created by HuangHui on 2022/3/23.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

    let container: NSPersistentContainer

    init() {
        Self.copyData()
        
        container = NSPersistentContainer(name: "lol_e_game_support")
        
        let fm = FileManager.default
        let targetURL = fm.urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathComponent("lol_e_game_support.sqlite")
        let desc = NSPersistentStoreDescription(url: targetURL)
        container.persistentStoreDescriptions = [desc]
        
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            print(storeDescription)
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
        container.viewContext.mergePolicy = NSMergeByPropertyStoreTrumpMergePolicy
    }
    
    static func copyData() {
        let fm = FileManager.default
        let targetURL = fm.urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathComponent("lol_e_game_support.sqlite")
        
        if !fm.fileExists(atPath: targetURL.path) {
            try! fm.copyItem(at: Bundle.main.url(forResource: "lol_e_game_support.sqlite", withExtension: nil)!, to: targetURL)
        }
    }
}
