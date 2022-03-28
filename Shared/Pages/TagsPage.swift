//
//  TagsView.swift
//  lol-e-game-support (iOS)
//
//  Created by HuangHui on 2022/3/28.
//

import SwiftUI

struct AllSeason: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State var text: String = ""
    
    @FetchRequest(sortDescriptors: [], animation: .default)private var items: FetchedResults<Season>
    
    var body: some View {
        VStack{
            HStack{
                TextField("", text: $text, onCommit: insert)
                Button("录入", action: insert)
            }
            .padding(.horizontal)
            List {
                ForEach(items) { item in
                    Text(item.desc ?? "数据丢失")
                        .contextMenu{
                            Button("删除") {
                                viewContext.delete(item)
                                try? viewContext.save()
                            }
                        }
                }
            }
        }
    }
    
    func insert() {
        if !text.isEmpty {
            let temp = Season(context: viewContext)
            temp.desc = text
            try? viewContext.save()
            text = ""
        }
    }
}

struct AllQuality: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State var text: String = ""
    
    @FetchRequest(
        sortDescriptors: [],
        animation: .default)
    private var items: FetchedResults<Quality>
    
    var body: some View {
        VStack{
            HStack{
                TextField("", text: $text, onCommit: insert)
                Button("录入", action: insert)
            }
            .padding(.horizontal)
            List {
                ForEach(items) { item in
                    Text(item.desc ?? "数据丢失")
                        .contextMenu{
                            Button("删除") {
                                viewContext.delete(item)
                                try? viewContext.save()
                            }
                        }
                }
            }
        }
    }
    
    func insert() {
        if !text.isEmpty {
            let temp = Quality(context: viewContext)
            temp.desc = text
            try? viewContext.save()
            text = ""
        }
    }
}

struct AllTags<T: Tag>: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State var text: String = ""
    
    @FetchRequest(
        sortDescriptors: [],
        animation: .default)
    private var items: FetchedResults<T>
    
    var body: some View {
        VStack{
            HStack{
                TextField("", text: $text, onCommit: insert)
                Button("录入", action: insert)
            }
            .padding(.horizontal)
            List {
                ForEach(items) { item in
                    Text(item.desc ?? "数据丢失")
                        .contextMenu{
                            Button("删除") {
                                viewContext.delete(item)
                                try? viewContext.save()
                            }
                        }
                }
            }
        }
    }
    
    func insert() {
        if !text.isEmpty {
            let temp = T(context: viewContext)
            temp.desc = text
            try? viewContext.save()
            text = ""
        }
    }
}
