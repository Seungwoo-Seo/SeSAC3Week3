//
//  TimelineViewController.swift
//  SeSAC3Week3
//
//  Created by 서승우 on 2023/08/02.
//

import UIKit

class TimelineViewController: UIViewController {

    @IBOutlet weak var todaycollectionView: UICollectionView!
    @IBOutlet weak var bestCollectionView: UICollectionView!


    override func viewDidLoad() {
        super.viewDidLoad()

        configureHierarchy()
    }
    
}

extension TimelineViewController: UICollectionViewDataSource {

    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return collectionView == todaycollectionView ? 3 : 10
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: TimelineCollectionViewCell.identifier,
            for: indexPath
        ) as! TimelineCollectionViewCell

        if collectionView == todaycollectionView {
            cell.contentView.backgroundColor = .yellow
            cell.contentsLabel.text = "Today: \(indexPath.item)"
        } else {
            cell.contentView.backgroundColor = .gray
            cell.contentsLabel.text = "Best: \(indexPath.item)"
        }

        return cell
    }

}

extension TimelineViewController: UICollectionViewDelegate {

}

private extension TimelineViewController {

    func configureCollectionViewLayout(collectionView: UICollectionView) {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 100, height: 100)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)

        collectionView.collectionViewLayout = layout
    }

    func configureTodayCollectionView() {
        configureCollectionViewLayout(
            collectionView: todaycollectionView
        )
        todaycollectionView.dataSource = self
        todaycollectionView.delegate = self

        let nib = UINib(
            nibName: TimelineCollectionViewCell.identifier,
            bundle: nil
        )
        todaycollectionView.register(
            nib,
            forCellWithReuseIdentifier: TimelineCollectionViewCell.identifier
        )
    }

    func configureBsetCollectionViewLayout() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(
            width: UIScreen.main.bounds.width,
            height: 200
        )
        layout.sectionInset = UIEdgeInsets(
            top: 0, left: 0, bottom: 0, right: 0
        )
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0

        bestCollectionView.collectionViewLayout = layout
    }

    func configureBestCollectionView() {
        configureBsetCollectionViewLayout()
        bestCollectionView.dataSource = self
        bestCollectionView.delegate = self
        bestCollectionView.isPagingEnabled = true

        let nib = UINib(
            nibName: TimelineCollectionViewCell.identifier,
            bundle: nil
        )
        bestCollectionView.register(
            nib,
            forCellWithReuseIdentifier: TimelineCollectionViewCell.identifier
        )
    }

    func configureHierarchy() {
        configureTodayCollectionView()
        configureBestCollectionView()
    }

}
