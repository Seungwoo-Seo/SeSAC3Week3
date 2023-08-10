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
    /// 도서 원래 판매가
    let originalPrice: Int
    /// 도서 세일 판매가
    let salePrice: Int
    /// 도서 표지 미리보기 URL
    let thumbnail: String
    /// 도서 출판날짜
    let datetime: String
    /// 도서 저자 리스트
    let authors: [String]
    /// 랜덤 RGB 값
    let randomRGB = CGFloat.randomRGB

    var thumbnailURL: URL? {
        return URL(string: thumbnail)
    }

    var authorsArrange: String {
        return authors.joined(separator: ", ")
    }

    var price: NSAttributedString {
        let op = originalPrice
            .originalPriceStyle(fontSize: 13)
        let sp = salePrice
            .salePriceStyle(fontSize: 15)
        op.priceSeparator.append(sp)

        return op
    }

}
