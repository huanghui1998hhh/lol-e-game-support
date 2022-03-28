//
//  lol_e_game_supportApp.swift
//  Shared
//
//  Created by HuangHui on 2022/3/23.
//

import SwiftUI

@main
struct lol_e_game_supportApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
