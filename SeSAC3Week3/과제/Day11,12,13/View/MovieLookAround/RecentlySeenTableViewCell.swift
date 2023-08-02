//
//  RecentlySeenTableViewCell.swift
//  SeSAC3Week3
//
//  Created by 서승우 on 2023/08/02.
//

import UIKit

protocol RecentlySeenTableViewCellDelegate: AnyObject {

    func didCollectionViewReloadData()

}

final class RecentlySeenTableViewCell: UITableViewCell {
    static let identifier = "RecentlySeenTableViewCell"

    var recentlySeenMovies: [Movie] = []

    @IBOutlet weak var collectionView: UICollectionView!

    weak var delegate: RecentlySeenTableViewCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        configureHierarchy()
    }

    func configure(movies: [Movie]) {
        recentlySeenMovies = movies
        delegate?.didCollectionViewReloadData()
    }

}

extension RecentlySeenTableViewCell: UICollectionViewDataSource {

    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return recentlySeenMovies.count
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: ImageCollectionViewCell.identifier,
            for: indexPath
        ) as! ImageCollectionViewCell

        let movie = recentlySeenMovies[indexPath.row]
        cell.configure(movie: movie)

        return cell
    }

//    func collectionView(
//        _ collectionView: UICollectionView,
//        layout collectionViewLayout: UICollectionViewLayout,
//        sizeForItemAt indexPath: IndexPath
//    ) -> CGSize {
//        let width = UIScreen.main.bounds.width / 4
//        let height = width * 1.5
//
//        return CGSize(width: width, height: height)
//    }

}

extension RecentlySeenTableViewCell: UICollectionViewDelegate {

}

private extension RecentlySeenTableViewCell {

    func configureCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self

        let spacing: CGFloat = 16.0
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = spacing

        let width = UIScreen.main.bounds.width / 4
        let height = width * 1.5
        layout.itemSize = CGSize(width: width, height: height)

        layout.sectionInset = UIEdgeInsets(
            top: spacing,
            left: spacing,
            bottom: spacing,
            right: spacing
        )
        collectionView.collectionViewLayout = layout

        // MARK: CC -> CollectionView Cell
        let imageCCNib = UINib(
            nibName: ImageCollectionViewCell.identifier,
            bundle: nil
        )
        collectionView.register(
            imageCCNib,
            forCellWithReuseIdentifier: ImageCollectionViewCell.identifier
        )
    }

    func configureHierarchy() {
        configureCollectionView()
    }

}
