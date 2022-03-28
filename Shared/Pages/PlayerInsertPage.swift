//
//  PlayerInsertPage.swift
//  lol-e-game-support
//
//  Created by HuangHui on 2022/3/28.
//

import SwiftUI

struct PlayerInsertPage: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @State var id: String = ""
    @State var name: String = ""
    @State var score: Double = 90
    @State var quality: Quality?
    @State var region: Region?
    @State var team: Team?
    @State var tag1: NormalTag?
    @State var tag2: NormalTag?
    @State var season: Season?
    @State var lane: Lane?
    
    @FetchRequest(sortDescriptors: [], animation: .default)private var qualitys: FetchedResults<Quality>
    @FetchRequest(sortDescriptors: [], animation: .default)private var lanes: FetchedResults<Lane>
    @FetchRequest(sortDescriptors: [], animation: .default)private var regions: FetchedResults<Region>
    @FetchRequest(sortDescriptors: [], animation: .default)private var teams: FetchedResults<Team>
    @FetchRequest(sortDescriptors: [], animation: .default)private var normalTags: FetchedResults<NormalTag>
    @FetchRequest(sortDescriptors: [], animation: .default)private var seasons: FetchedResults<Season>
    
    var body: some View {
        VStack {
            TextField("选手ID", text: $id)
            TextField("选手姓名", text: $name)
            HStack {
                Text("\(Int(score))")
                Slider(value: $score, in: 40...100)
            }
            Group{
                Menu(quality?.desc ?? "请选择品质") {
                    ForEach(qualitys) { item in
                        Button(item.desc ?? "数据丢失") {
                            self.quality = item
                        }
                    }
                }
                Menu(season?.desc ?? "请选择赛季") {
                    ForEach(seasons) { item in
                        Button(item.desc ?? "数据丢失") {
                            self.season = item
                        }
                    }
                }
                Menu(team?.desc ?? "请选择战队") {
                    ForEach(teams) { item in
                        Button(item.desc ?? "数据丢失") {
                            self.team = item
                        }
                    }
                }
                Menu(region?.desc ?? "请选择地区") {
                    ForEach(regions) { item in
                        Button(item.desc ?? "数据丢失") {
                            self.region = item
                        }
                    }
                }
                tagsMenu
            }
            Button("录入", action: insert)
        }
        .padding(.horizontal)
    }
    
    @ViewBuilder var tagsMenu: some View {
        Menu(lane?.desc ?? "请选择位置") {
            ForEach(lanes) { item in
                Button(item.desc ?? "数据丢失") {
                    self.lane = item
                }
            }
        }
        Menu(tag1?.desc ?? "请选择tag1") {
            ForEach(normalTags) { item in
                Button(item.desc ?? "数据丢失") {
                    self.tag1 = item
                }
            }
        }
        Menu(tag2?.desc ?? "请选择tag2") {
            ForEach(normalTags) { item in
                Button(item.desc ?? "数据丢失") {
                    self.tag2 = item
                }
            }
        }
    }
    
    func insert() {
        if let quality = quality,
           let region = region,
           let team = team,
           let tag1 = tag1,
           let tag2 = tag2,
           let lane = lane,
           let season = season,
           !id.isEmpty,
           !name.isEmpty
        {
            let person = Person(context: viewContext)
            person.name = name
            let player = Player(context: viewContext)
            player.playerID = id
            player.score = Int16(score)
            player.quality = quality
            player.lane = lane
            player.region = region
            player.season = season
            player.team = team
            player.normalTags = [tag1, tag2]
            try? viewContext.save()
        }
    }
}
