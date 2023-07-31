//
//  MovieCollectionViewController.swift
//  SeSAC3Week3
//
//  Created by 서승우 on 2023/07/31.
//

import UIKit

final class MovieCollectionViewController: UICollectionViewController {

    let movies = MovieInfo().movie

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

    func pushToMovieDetailViewController(movie: Movie) {
        let vc = storyboard?.instantiateViewController(
            withIdentifier: "MovieDetailViewController"
        ) as! MovieDetailViewController

        vc.movieTitle = movie.title

        navigationController?.pushViewController(
            vc,
            animated: true
        )
    }

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

}
