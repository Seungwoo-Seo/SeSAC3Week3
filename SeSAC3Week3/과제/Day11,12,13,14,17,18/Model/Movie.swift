//
//  Movie.swift
//  SeSAC3Week3
//
//  Created by 서승우 on 2023/08/01.
//

import Foundation

struct Movie {
    let title: String
    let releaseDate: String
    let runtime: Int
    let overview: String
    let rate: Double

    var like: Bool = false

    var basicInfo: String {
        return "\(releaseDate) | \(runtime)분 | \(rate)점"
    }
}
