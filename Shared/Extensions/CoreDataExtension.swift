//
//  CoreDataExtension.swift
//  lol-e-game-support (iOS)
//
//  Created by HuangHui on 2022/3/28.
//

import Foundation
import CoreData

extension Player {
    var tags: Set<String> {
        var temp: Set<String> = []
        if let region = region?.desc {
            temp.insert(region)
        }
        if let team = team?.desc {
            temp.insert(team)
        }
        normalTags?.forEach({ e in
            if let e = (e as? NormalTag)?.desc {
                temp.insert(e)
            }
        })
        return temp
    }
    
    var prettyName: String {
        "\(team?.desc ?? "未知战队").\(playerID ?? "未知选手")"
    }
}

extension Region {
    static func getItem(_ desc: String) -> Self {
        let context = PersistenceController.shared.container.viewContext
        let fetchRequest = NSFetchRequest<Self>(entityName: "Region")
        fetchRequest.predicate = NSPredicate(format: "%K Like %@", "desc", desc)
        let result = try! context.fetch(fetchRequest)
        return result.first!
    }
}
extension Team {
    static func getItem(_ desc: String) -> Self {
        let context = PersistenceController.shared.container.viewContext
        let fetchRequest = NSFetchRequest<Self>(entityName: "Team")
        fetchRequest.predicate = NSPredicate(format: "%K Like %@", "desc", desc)
        let result = try! context.fetch(fetchRequest)
        return result.first!
    }
}
extension NormalTag {
    static func getItem(_ desc: String) -> Self {
        let context = PersistenceController.shared.container.viewContext
        let fetchRequest = NSFetchRequest<Self>(entityName: "NormalTag")
        fetchRequest.predicate = NSPredicate(format: "%K Like %@", "desc", desc)
        let result = try! context.fetch(fetchRequest)
        return result.first!
    }
}
