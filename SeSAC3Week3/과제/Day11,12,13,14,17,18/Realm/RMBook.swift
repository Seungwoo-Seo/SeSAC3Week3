//
//  RMBook.swift
//  SeSAC3Week3
//
//  Created by 서승우 on 2023/09/04.
//

import Foundation
import RealmSwift

class RMBook: Object {
    @Persisted(primaryKey: true) var _id: ObjectId
    /// 도서 제목
    @Persisted var title: String
    /// 도서 소개
    @Persisted var content: String
    /// 도서 원래 판매가
    @Persisted var originalPrice: Int
    /// 도서 세일 판매가
    @Persisted var salePrice: Int
    /// 도서 표지 미리보기 URL
    @Persisted var thumbnail: String
    /// 도서 출판날짜
    @Persisted var datetime: String
    /// 도서 저자 리스트
    @Persisted var authors: List<String>
    @Persisted var date: Date

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

    convenience init(
        title: String,
        content: String,
        originalPrice: Int,
        salePrice: Int,
        thumbnail: String,
        datetime: String,
        authors: List<String>,
        date: Date = Date()
    ) {
        self.init()
        self.title = title
        self.content = content
        self.originalPrice = originalPrice
        self.salePrice = salePrice
        self.thumbnail = thumbnail
        self.datetime = datetime
        self.authors = authors
        self.date = date
    }
}
