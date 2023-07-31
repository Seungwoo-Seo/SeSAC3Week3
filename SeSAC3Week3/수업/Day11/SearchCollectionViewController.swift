//
//  SearchCollectionViewController.swift
//  SeSAC3Week3
//
//  Created by 서승우 on 2023/07/31.
//

import UIKit

final class SearchCollectionViewController: UICollectionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let nib = UINib(
            nibName: "SearchCollectionViewCell",
            bundle: nil
        )

        collectionView.register(
            nib,
            forCellWithReuseIdentifier: SearchCollectionViewCell.identifier
        )

        setCollectionViewLayout()
    }

    //
    func setCollectionViewLayout() {
        let spacing: CGFloat = 16.0

        let width = (UIScreen.main.bounds.width - spacing * 6) / 5
        let height = width

        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = spacing
        layout.minimumLineSpacing = spacing
        layout.scrollDirection = .vertical
        layout.sectionInset = .init(
            top: spacing,
            left: spacing,
            bottom: spacing,
            right: spacing
        )
        layout.itemSize = CGSize(
            width: width,
            height: height
        )

        collectionView.collectionViewLayout = layout
    }

    override func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return 100
    }

    override func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: SearchCollectionViewCell.identifier,
            for: indexPath
        ) as? SearchCollectionViewCell

        cell?.backgroundColor = .brown
        cell?.contentsLabel.text = "\(indexPath)"

        return cell ?? UICollectionViewCell()
    }

    override func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {

    }

}

extension SearchCollectionViewController: UICollectionViewDelegateFlowLayout {

//    func collectionView(
//        _ collectionView: UICollectionView,
//        layout collectionViewLayout: UICollectionViewLayout,
//        sizeForItemAt indexPath: IndexPath
//    ) -> CGSize {
//        let itemSpacing: CGFloat = 16.0
//        let inset: CGFloat = 16.0
//        let width = (collectionView.bounds.width - itemSpacing - inset * 3) / 3
//        let height = width
//
//        return CGSize(width: width, height: height)
//    }

}
