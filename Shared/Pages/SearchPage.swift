//
//  SearchPage.swift
//  lol-e-game-support (iOS)
//
//  Created by HuangHui on 2022/3/28.
//

import SwiftUI

struct EightTags {
    var region: Region?
    var team0: Team?
    var team1: Team?
    var team2: Team?
    var team3: Team?
    var normalTag0: NormalTag?
    var normalTag1: NormalTag?
    var normalTag2: NormalTag?
    
    var values: [String] {
        [region, team0, team1, team2, team3, normalTag0, normalTag1, normalTag2].compactMap { $0?.desc }
    }
}

struct SearchPage: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(sortDescriptors: [
        NSSortDescriptor(keyPath: \Player.lane, ascending: false)
    ], animation: .default)private var players: FetchedResults<Player>
    
    @FetchRequest(sortDescriptors: [], animation: .default) private var regions: FetchedResults<Region>
    @FetchRequest(sortDescriptors: [], animation: .default) private var teams: FetchedResults<Team>
    @FetchRequest(sortDescriptors: [], animation: .default) private var normalTags: FetchedResults<NormalTag>
    
    @State var result: [Set<String>:[String]] = [:]
    @State var manualTags = ""
    @State var eightTags = EightTags()
    @State var matchTagsNum: Int = 3
    @State var manualInputEnable: Bool = false
    
    var body: some View {
        VStack{
            Toggle("手动输入标签", isOn: $manualInputEnable.animation(.easeInOut))
            if manualInputEnable {
                TextField("请输入完整的标签，并以空格隔开", text: $manualTags)
            }else {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 80, maximum: 120), spacing: 12)], spacing: 12) {
                    EightTagSearcher(bindingTag: $eightTags.region, items: regions)
                    EightTagSearcher(bindingTag: $eightTags.team0, items: teams)
                    EightTagSearcher(bindingTag: $eightTags.team1, items: teams)
                    EightTagSearcher(bindingTag: $eightTags.team2, items: teams)
                    EightTagSearcher(bindingTag: $eightTags.team3, items: teams)
                    EightTagSearcher(bindingTag: $eightTags.normalTag0, items: normalTags)
                    EightTagSearcher(bindingTag: $eightTags.normalTag1, items: normalTags)
                    EightTagSearcher(bindingTag: $eightTags.normalTag2, items: normalTags)
                }
                .transition(.opacity)
            }
            Button("搜索") {
                let tags: [String]
                if manualInputEnable {
                    tags = manualTags.split(separator: " ").map(String.init)
                }else {
                    tags = eightTags.values
                }
                let firstTry = tagsHandle(tags: tags, getNum: 3)
                if firstTry.isEmpty {
                    self.result = tagsHandle(tags: tags, getNum: 2)
                }else {
                    self.result = firstTry
                }
            }
            ForEach(result.sorted(by: { l, r in
                l.value.first! < r.value.first!
            }), id:\.key) { key, value in
                HStack {
                    Text("选择")
                        .frame(width: 80)
                    Text(key.joined(separator: "-"))
                        .frame(width: 200)
                    Text(key.count == 3 ? "一定能匹配到" : "有机会匹配到")
                        .frame(width: 100)
                    Text(value.joined(separator: " / "))
                        .frame(width: 200)
                }
            }
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
    }
    
    func tagsHandle(tags: [String], getNum: Int) -> [Set<String>:[String]] {
        let combines = combinations(tags, getNum).map(Set.init)
        var temp: [Set<String>:[String]] = [:]
        players.forEach { player in
            let playerTags = player.tags
            combines.forEach { combine in
                if combine.isSubset(of: playerTags) {
                    if var preValue = temp[combine] {
                        preValue.append(player.prettyName)
                        temp.updateValue(preValue, forKey: combine)
                    }else {
                        temp[combine] = [player.prettyName]
                    }
                }
            }
        }
        return temp
    }
}

struct EightTagSearcher<T: Tag>: View {
    @Binding var bindingTag: T?
    var items: FetchedResults<T>
    
    var body: some View {
        Menu(bindingTag?.desc ?? "请选择") {
            ForEach(items) { item in
                Button(item.desc ?? "数据丢失") {
                    self.bindingTag = item
                }
            }
        }
    }
}
