//
//  MovieCollectionViewController.swift
//  SeSAC3Week3
//
//  Created by 서승우 on 2023/07/31.
//

import UIKit

final class MovieCollectionViewController: UICollectionViewController {

    var movies = MovieInfo().movie
    var searchMovies: [Movie] = []

    var isSearch = false

    let searchBar = UISearchBar()

    override func viewDidLoad() {
        super.viewDidLoad()

        configureHierarchy()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        configureNavigationBar_default()
    }

    override func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        if isSearch {
            return searchMovies.count
        } else {
            return movies.count
        }
    }

    override func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: MovieCollectionViewCell.identifier,
            for: indexPath
        ) as! MovieCollectionViewCell

        let movie: Movie
        if isSearch {
            movie = searchMovies[indexPath.row]
        } else {
            movie = movies[indexPath.row]
        }
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
        let movie: Movie
        if isSearch {
            movie = searchMovies[indexPath.row]
        } else {
            movie = movies[indexPath.row]
        }
        pushToMovieDetailViewController(movie: movie)
    }

}

extension MovieCollectionViewController: UISearchBarDelegate {

    func searchBarSearchButtonClicked(
        _ searchBar: UISearchBar
    ) {
        searchToMovie()
    }

    func searchBarCancelButtonClicked(
        _ searchBar: UISearchBar
    ) {
        restorationToMovies()
        searchBar.resignFirstResponder()
    }

    func searchBar(
        _ searchBar: UISearchBar,
        textDidChange searchText: String
    ) {
        searchToMovie()

        collectionView.becomeFirstResponder()
        print(collectionView.isFirstResponder)
        print(searchBar.isFirstResponder)
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

// UI 세팅
private extension MovieCollectionViewController {

    func configureNavigationBar() {
        navigationItem.title = "고래밥님의 책장"
//        let rightBarButtonItem = UIBarButtonItem(
//            image: UIImage(systemName: "magnifyingglass"),
//            style: .plain,
//            target: self,
//            action: #selector(didTapRightBarButtonItem)
//        )
//        navigationItem.rightBarButtonItem = rightBarButtonItem
        navigationItem.backButtonTitle = ""
    }

    func configureSearchBar() {
        searchBar.delegate = self
        searchBar.placeholder = "찾고 싶은 영화를 검색하세요."
        searchBar.showsCancelButton = true
        searchBar.searchTextField.clearButtonMode = .never

        // 혐
        if let containerView = searchBar.subviews.first?.subviews.last {
            for subView in containerView.subviews {
                if let button = subView as? UIButton {
                    button.setTitle("취소", for: .normal)
                }
            }
        }

        navigationItem.titleView = searchBar
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
        configureSearchBar()
        configureCollectionView()
    }

}

// 동작
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
            withIdentifier: "MovieDetailTableViewController"
        ) as! MovieDetailTableViewController

        vc.movie = movie
        vc.delegate = self

        navigationController?.pushViewController(
            vc,
            animated: true
        )
    }

}

// 비즈니스
private extension MovieCollectionViewController {

    func searchToMovie() {
        guard let searchText = searchBar.text?.lowercased()
        else {return}

        guard !(searchText
            .trimmingCharacters(in: .whitespaces)
            .isEmpty)
        else {
            restorationToMovies()
            return
        }

        isSearch = true
        searchMovies.removeAll()

        for movie in movies {
            let title = movie.title.lowercased()
            if title.contains(searchText) {
                searchMovies.append(movie)
            }
        }

        collectionView.reloadData()
    }

    func restorationToMovies() {
        isSearch = false
        searchMovies.removeAll()
        searchBar.text = ""
        collectionView.reloadData()
    }

}
