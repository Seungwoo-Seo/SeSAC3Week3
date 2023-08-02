//
//  MovieCollectionViewController.swift
//  SeSAC3Week3
//
//  Created by 서승우 on 2023/07/31.
//

import UIKit

final class MovieCollectionViewController: UICollectionViewController {

    var movies = MovieInfo().movie

    override func viewDidLoad() {
        super.viewDidLoad()

        configureHierarchy()
    }

    override func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return movies.count
    }

    override func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: MovieCollectionViewCell.identifier,
            for: indexPath
        ) as! MovieCollectionViewCell

        let movie = movies[indexPath.row]
        cell.configureCell(movie: movie)

        // MARK: 다시
        cell.likeButton.addTarget(
            self,
            action: #selector(didTapLikeButton),
            for: .touchUpInside
        )
        cell.likeButton.tag = indexPath.row

        return cell
    }

    override func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        let movie = movies[indexPath.row]
        pushToMovieDetailViewController(movie: movie)
    }

}

extension MovieCollectionViewController: MovieDetailTableViewHeaderDelegate {

    func cancelTheLike(movie: Movie?) {
        if let index = movies.firstIndex(where: { $0.title == movie?.title }) {
            movies[index].like.toggle()

            let cell = collectionView.cellForItem(
                at: IndexPath(row: index, section: 0)
            ) as! MovieCollectionViewCell

            cell.likeButton.toggle
        }
    }

    func didTapBackButton() {}

}

private extension MovieCollectionViewController {

    func configureNavigationBar() {
        navigationController?.navigationBar.tintColor = .black
        navigationItem.title = "고래밥님의 책장"
        let rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "magnifyingglass"),
            style: .plain,
            target: self,
            action: #selector(didTapRightBarButtonItem)
        )
        navigationItem.rightBarButtonItem = rightBarButtonItem

        navigationItem.backButtonTitle = ""
    }

    func configureCollectionView() {
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

        collectionView.collectionViewLayout = layout
    }

    func configureHierarchy() {
        configureNavigationBar()
        configureCollectionView()
    }

}

private extension MovieCollectionViewController {

    @objc
    func didTapRightBarButtonItem(_ sender: UIBarButtonItem) {
        let vc = storyboard?.instantiateViewController(
            withIdentifier: "MovieSearchViewController"
        ) as! MovieSearchViewController

        let navigationController = UINavigationController(
            rootViewController: vc
        )
        navigationController.modalPresentationStyle = .fullScreen

        present(navigationController, animated: true)
    }

    @objc
    func didTapLikeButton(_ sender: UIButton) {
        sender.toggle
        movies[sender.tag].like = sender.isSelected
    }

    func pushToMovieDetailViewController(movie: Movie) {
        let vc = storyboard?.instantiateViewController(
            withIdentifier: "MovieDetailViewController"
        ) as! MovieDetailViewController

        vc.movie = movie
        vc.delegate = self

        navigationController?.pushViewController(
            vc,
            animated: true
        )
    }

}
