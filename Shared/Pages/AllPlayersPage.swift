//
//  AllPlayersPage.swift
//  lol-e-game-support
//
//  Created by HuangHui on 2022/3/28.
//

import SwiftUI

struct AllPlayersPage: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(sortDescriptors: [
        NSSortDescriptor(keyPath: \Player.lane, ascending: false)
    ], animation: .default)private var players: FetchedResults<Player>
    
    var body: some View {
        List{
            ForEach(players, id: \.self.id) { player in
                PlayerItem(player: player)
            }
        }
    }
}

struct PlayerItem: View {
    @Environment(\.managedObjectContext) private var viewContext
    @ObservedObject var player: Player
    
    var body: some View {
        HStack {
            Text((player.team?.desc ?? "数据丢失") + "-" + (player.playerID ?? "数据丢失"))
                .frame(width: 100)
            Text("评分: \(player.score)")
                .frame(width: 100)
            Text(player.tags.description)
        }
        .contextMenu{
            Button("删除") {
                viewContext.delete(player)
                try? viewContext.save()
            }
        }
    }
}
