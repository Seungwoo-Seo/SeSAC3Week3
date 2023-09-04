//
//  ReuseableProtocol.swift
//  SeSAC3Week3
//
//  Created by 서승우 on 2023/09/04.
//

import UIKit

protocol ReuseableProtocol {
    static var identifier: String {get}
}

extension UITableView: ReuseableProtocol {
    static var identifier: String {
        return String(describing: self)
    }
}

extension UICollectionView: ReuseableProtocol {
    static var identifier: String {
        return String(describing: self)
    }
}

extension UITableViewCell: ReuseableProtocol {
    static var identifier: String {
        return String(describing: self)
    }
}

extension UICollectionReusableView: ReuseableProtocol {
    static var identifier: String {
        return String(describing: self)
    }
}
