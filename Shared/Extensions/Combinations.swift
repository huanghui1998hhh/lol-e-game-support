//
//  File.swift
//  lol-e-game-support (iOS)
//
//  Created by HuangHui on 2022/3/25.
//

import Foundation

@inlinable public func combinations<T>(_ source: [T], _ takenBy : Int) -> [[T]] {
    if(source.count == takenBy) {
        return [source]
    }

    if(source.isEmpty) {
        return []
    }

    if(takenBy == 0) {
        return []
    }

    if(takenBy == 1) {
        return source.map { [$0] }
    }

    var result : [[T]] = []

    let rest = Array(source.suffix(from: 1))
    let subCombos = combinations(rest, takenBy - 1)
    result += subCombos.map { [source[0]] + $0 }
    result += combinations(rest, takenBy)
    return result
}
