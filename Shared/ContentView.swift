//
//  ContentView.swift
//  Shared
//
//  Created by HuangHui on 2022/3/23.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    var body: some View {
        SearchPage()
            .frame(width: 800, height: 500)
//        NavigationView {
//            List {
//                NavigationLink("所有队伍") {
//                    AllTags<Team>()
//                }
//                NavigationLink("所有地区") {
//                    AllTags<Region>()
//                }
//                NavigationLink("所有位置") {
//                    AllTags<Lane>()
//                }
//                NavigationLink("其他tag") {
//                    AllTags<NormalTag>()
//                }
//                NavigationLink("所有品质") {
//                    AllQuality()
//                }
//                NavigationLink("所有赛季") {
//                    AllSeason()
//                }
//                NavigationLink("选手录入") {
//                    PlayerInsertPage()
//                }
//                NavigationLink("所有选手") {
//                    AllPlayersPage()
//                }
//                NavigationLink("搜索") {
//                    SearchPage()
//                }
//            }
//        }
    }
}

