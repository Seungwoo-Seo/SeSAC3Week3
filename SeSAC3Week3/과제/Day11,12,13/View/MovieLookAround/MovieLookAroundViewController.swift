//
//  MovieLookAroundViewController.swift
//  SeSAC3Week3
//
//  Created by 서승우 on 2023/08/02.
//

import UIKit

enum MovieLookAroundTableViewSecionKind: Int, CaseIterable {
    case 최근본작품
    case 요즘인기작품

    var headerTitle: String? {
        switch self {
        case .최근본작품: return "최근 본 작품"
        case .요즘인기작품: return "요즘 인기 작품"
        }
    }
}

final class MovieLookAroundViewController: UIViewController {

    var recentlySeenMovies: [Movie] = MovieInfo().movie
    var popularTheseDaysMovies: [Movie] = MovieInfo().movie

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

}

extension MovieLookAroundViewController: RecentlySeenTableViewCellDelegate {

    func didCollectionViewReloadData() {
//        tableView.reloadData()
        print("불렸지?")
//        tableView.reloadSections(
//            IndexSet(integer: 0),
//            with: .automatic
//        )
    }

}

private extension MovieLookAroundViewController {

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
        configureTableView()
    }

}
