//
//  DynamicHeightCollectionView.swift
//  SeSAC3Week3
//
//  Created by 서승우 on 2023/08/02.
//

import UIKit

final class DynamicHeightCollectionView: UICollectionView {

    override func layoutSubviews() {
        super.layoutSubviews()

        if bounds.size != intrinsicContentSize {
            self.invalidateIntrinsicContentSize()
        }
    }

    override var intrinsicContentSize: CGSize {
        return collectionViewLayout.collectionViewContentSize
    }

}
