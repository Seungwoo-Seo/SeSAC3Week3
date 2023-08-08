//
//  Book.swift
//  SeSAC3Week3
//
//  Created by 서승우 on 2023/08/08.
//

import Foundation

struct Book {
    /// 도서 제목
    let title: String
    /// 도서 소개
    let description: String
    /// 도서 판매가
    let price: Int
    /// 도서 표지 미리보기 URL
    let thumbnail: String
    /// 도서 출판날짜
    let datetime: String
    /// 도서 저자 리스트
    let authors: [String]

    var thumbnailImage: URL? {
        return URL(string: thumbnail)
    }
}
