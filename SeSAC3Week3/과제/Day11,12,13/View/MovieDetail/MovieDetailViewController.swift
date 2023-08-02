//
//  MovieDetailViewController.swift
//  SeSAC3Week3
//
//  Created by 서승우 on 2023/07/31.
//

import UIKit

final class MovieDetailViewController: UIViewController {
    static let identifier = "MovieDetailViewController"

    var movie: Movie?
    weak var delegate: MovieDetailTableViewHeaderDelegate?

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableHeaderView: MovieDetailTableViewHeader!

    override func viewDidLoad() {
        super.viewDidLoad()

        configureHierarchy()
    }

}

extension MovieDetailViewController: UITableViewDataSource {

    func numberOfSections(
        in tableView: UITableView
    ) -> Int {
        return MovieDetailTableViewSecionKind.allCases.count
    }

    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        return  MovieDetailTableViewSecionKind.allCases[section].numberOfRowsInSection
    }

    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        guard let movie = movie
        else {return UITableViewCell()}

        let section = MovieDetailTableViewSecionKind.allCases[indexPath.section]

        switch section {
        case .기본정보:
            let cell = tableView.dequeueReusableCell(
                withIdentifier: MovieDetailBasicInformationTableViewCell.identifier,
                for: indexPath
            ) as! MovieDetailBasicInformationTableViewCell

            cell.configureCell(movie: movie)

            return cell

        case .개요:
            let cell = tableView.dequeueReusableCell(
                withIdentifier: MovieDetailOverviewTableViewCell.identifier,
                for: indexPath
            ) as! MovieDetailOverviewTableViewCell

            cell.configureCell(movie: movie)

            return cell

        case .공백:
            let cell = tableView.dequeueReusableCell(
                withIdentifier: "Cell",
                for: indexPath
            )

            return cell
        }
    }

}

extension MovieDetailViewController: UITableViewDelegate {

    func tableView(
        _ tableView: UITableView,
        viewForHeaderInSection section: Int
    ) -> UIView? {
        let section = MovieDetailTableViewSecionKind.allCases[section]

        switch section {
        case .기본정보: return nil
        case .개요:
            let header = tableView.dequeueReusableHeaderFooterView(
                withIdentifier: MovieDetailTableViewSectionHeader.identifier
            ) as! MovieDetailTableViewSectionHeader

            header.configureHeader(title: section.headerTitle)

            return header

        case .공백:
            let header = tableView.dequeueReusableHeaderFooterView(
                withIdentifier: MovieDetailTableViewSectionHeader.identifier
            ) as! MovieDetailTableViewSectionHeader

            return header
        }
    }

    func tableView(
        _ tableView: UITableView,
        viewForFooterInSection section: Int
    ) -> UIView? {
        let section = MovieDetailTableViewSecionKind.allCases[section]

        switch section {
        case .기본정보:
            let footer = tableView.dequeueReusableHeaderFooterView(
                withIdentifier: MovieDetailTableViewSectionFooter.identifier
            )

            return footer

        case .개요:
            let footer = tableView.dequeueReusableHeaderFooterView(
                withIdentifier: MovieDetailTableViewSectionFooter.identifier
            )

            footer?.contentView.backgroundColor = .systemBackground

            return footer

        case .공백: return nil
        }
    }

}

extension MovieDetailViewController: MovieDetailTableViewHeaderDelegate {

    func cancelTheLike(movie: Movie?) {}

    func didTapBackButton() {
        dismiss(animated: true)
    }

}

private extension MovieDetailViewController {

    func configureNavigationBar() {
        navigationController?.navigationBar.backgroundColor = .clear
        navigationController?.navigationBar.tintColor = .systemBackground
    }

    func configureTableHeaderView() {
        tableHeaderView.frame.size.height = 180
        tableHeaderView.homeDelegate = delegate
        tableHeaderView.detailDelegate = self
        if navigationController != nil {
            tableHeaderView.configure(movie: movie!)
        } else {
            tableHeaderView.configure(
                movie: movie!,
                isHidden: false
            )
        }
    }

    func configureTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.sectionHeaderHeight = UITableView.automaticDimension
        tableView.sectionFooterHeight = 1

        // cell 등록
        let basicInformationNib = UINib(
            nibName: MovieDetailBasicInformationTableViewCell.identifier,
            bundle: nil
        )
        let overviewNib = UINib(
            nibName: MovieDetailOverviewTableViewCell.identifier,
            bundle: nil
        )
        tableView.register(
            basicInformationNib,
            forCellReuseIdentifier: MovieDetailBasicInformationTableViewCell.identifier
        )
        tableView.register(
            overviewNib,
            forCellReuseIdentifier: MovieDetailOverviewTableViewCell.identifier
        )
        tableView.register(
            UITableViewCell.self,
            forCellReuseIdentifier: "Cell"
        )

        // header footer 등록
        tableView.register(
            MovieDetailTableViewSectionHeader.self,
            forHeaderFooterViewReuseIdentifier: MovieDetailTableViewSectionHeader.identifier
        )
        tableView.register(
            MovieDetailTableViewSectionFooter.self,
            forHeaderFooterViewReuseIdentifier: MovieDetailTableViewSectionFooter.identifier
        )
    }

    func configureHierarchy() {
        configureNavigationBar()
        configureTableHeaderView()
        configureTableView()
    }

}
