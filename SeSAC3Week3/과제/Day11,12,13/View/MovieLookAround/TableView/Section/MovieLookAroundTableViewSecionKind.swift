//
//  MovieLookAroundTableViewSecionKind.swift
//  SeSAC3Week3
//
//  Created by 서승우 on 2023/08/02.
//

import Foundation

enum MovieLookAroundTableViewSecionKind: Int, CaseIterable {
    case 최근본작품
    case 요즘인기작품

    var headerTitle: String? {
        switch self {
        case .최근본작품: return "최근 본 작품"
        case .요즘인기작품: return "요즘 인기 작품"
        }
    }
}
