//
//  BookHomeCollectionView.swift
//  SeSAC3Week3
//
//  Created by 서승우 on 2023/09/04.
//

import UIKit

final class BookHomeCollectionView: UICollectionView {

    required init?(coder: NSCoder) {
        super.init(coder: coder)

        initalConfigure()
    }

    private func initalConfigure() {
        let spacing: CGFloat = 16.0
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        layout.sectionInset = UIEdgeInsets(
            top: spacing,
            left: spacing,
            bottom: spacing,
            right: spacing
        )

        let width = (UIScreen.main.bounds.width - spacing * 3) / 2
        let height = width
        layout.itemSize = CGSize(width: width, height: height)

        collectionViewLayout = layout

        let nib = UINib(
            nibName: BookCollectionViewCell.identifier,
            bundle: nil
        )
        register(
            nib,
            forCellWithReuseIdentifier: BookCollectionViewCell.identifier
        )
    }

}
