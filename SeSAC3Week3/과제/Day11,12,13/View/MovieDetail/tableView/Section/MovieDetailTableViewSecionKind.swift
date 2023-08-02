//
//  MovieDetailTableViewSecionKind.swift
//  SeSAC3Week3
//
//  Created by 서승우 on 2023/08/01.
//

import Foundation

enum MovieDetailTableViewSecionKind: Int, CaseIterable {
    case 기본정보
    case 개요
    case 공백

    var numberOfRowsInSection: Int {
        switch self {
        case .기본정보, .개요: return 1
        case .공백: return 20
        }
    }

    var headerTitle: String? {
        switch self {
        case .기본정보: return nil
        case .개요: return "개요"
        case .공백: return nil
        }
    }
}
