//
//  MovieLookAroundViewController.swift
//  SeSAC3Week3
//
//  Created by 서승우 on 2023/08/02.
//

import UIKit

final class MovieLookAroundViewController: UIViewController {

    var recentlySeenMovies: [Movie] = MovieInfo().movie.shuffled()
    var popularTheseDaysMovies: [Movie] = MovieInfo().movie.shuffled()

    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        configureHierarchy()
    }

}

extension MovieLookAroundViewController: UITableViewDataSource {

    func numberOfSections(
        in tableView: UITableView
    ) -> Int {
        return MovieLookAroundTableViewSecionKind.allCases.count
    }

    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        let section = MovieLookAroundTableViewSecionKind.allCases[section]

        switch section {
        case .최근본작품: return 1
        case .요즘인기작품: return popularTheseDaysMovies.count
        }
    }

    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let section = MovieLookAroundTableViewSecionKind.allCases[indexPath.section]

        switch section {
        case .최근본작품:
            let cell = tableView.dequeueReusableCell(
                withIdentifier: RecentlySeenTableViewCell.identifier,
                for: indexPath
            ) as! RecentlySeenTableViewCell

            cell.delegate = self
            cell.configure(movies: recentlySeenMovies)

            return cell

        case .요즘인기작품:
            let cell = tableView.dequeueReusableCell(
                withIdentifier: PopularTheseDaysTableViewCell.identifier,
                for: indexPath
            ) as! PopularTheseDaysTableViewCell

            let movie = popularTheseDaysMovies[indexPath.row]
            cell.configure(movie: movie)

            return cell
        }
    }

}

extension MovieLookAroundViewController: UITableViewDelegate {

    func tableView(
        _ tableView: UITableView,
        titleForHeaderInSection section: Int
    ) -> String? {
        let section = MovieLookAroundTableViewSecionKind.allCases[section]

        return section.headerTitle
    }

    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        let section = MovieLookAroundTableViewSecionKind.allCases[indexPath.section]

        let movie: Movie
        switch section {
        case .최근본작품: return
        case .요즘인기작품:
            movie = popularTheseDaysMovies[indexPath.row]
        }

        presentToMovieDetailViewController(movie: movie)
    }

}

extension MovieLookAroundViewController: RecentlySeenTableViewCellDelegate {

    func didSelectItemAt(movie: Movie) {
        let vc = storyboard?.instantiateViewController(
            withIdentifier: MovieDetailTableViewController.identifier
        ) as! MovieDetailTableViewController
        vc.modalPresentationStyle = .fullScreen
        vc.movie = movie

        present(vc, animated: true)
    }

}

private extension MovieLookAroundViewController {

    func configureNavigationBar() {
        navigationItem.title = "둘러보기"
    }

    func configureTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableView.automaticDimension
        

        let recentlySeenNib = UINib(
            nibName: RecentlySeenTableViewCell.identifier,
            bundle: nil
        )
        let popularTheseDaysNib = UINib(
            nibName: PopularTheseDaysTableViewCell.identifier,
            bundle: nil
        )
        tableView.register(
            recentlySeenNib,
            forCellReuseIdentifier: RecentlySeenTableViewCell.identifier
        )
        tableView.register(
            popularTheseDaysNib,
            forCellReuseIdentifier: PopularTheseDaysTableViewCell.identifier
        )
    }

    func configureHierarchy() {
        configureNavigationBar()
        configureTableView()
    }

}

private extension MovieLookAroundViewController {

    func presentToMovieDetailViewController(movie: Movie) {
        let vc = storyboard?.instantiateViewController(
            withIdentifier: MovieDetailTableViewController.identifier
        ) as! MovieDetailTableViewController
        vc.modalPresentationStyle = .fullScreen
        vc.movie = movie

        present(vc, animated: true)
    }

}
