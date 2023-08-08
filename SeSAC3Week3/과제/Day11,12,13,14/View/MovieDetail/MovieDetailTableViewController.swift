//
//  MovieDetailTableViewController.swift
//  SeSAC3Week3
//
//  Created by 서승우 on 2023/07/31.
//

import UIKit

final class MovieDetailTableViewController: UITableViewController {
    static let identifier = "MovieDetailViewController"

    var movie: Movie?
    weak var delegate: MovieDetailTableViewHeaderDelegate?

    @IBOutlet weak var tableHeaderView: MovieDetailTableViewHeader!

    override func viewDidLoad() {
        super.viewDidLoad()

        configureHierarchy()
    }

}

extension MovieDetailTableViewController {

    override func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        return 1
    }

    override func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        guard let movie = movie
        else {return UITableViewCell()}

        let cell = tableView.dequeueReusableCell(
            withIdentifier: MovieDetailInfoTableViewCell.identifier,
            for: indexPath
        ) as! MovieDetailInfoTableViewCell

        cell.configure(
            movie: movie
        )

        return cell
    }

}

extension MovieDetailTableViewController: MovieDetailTableViewHeaderDelegate {

    func cancelTheLike(movie: Movie?) {}

    func didTapBackButton() {
        dismiss(animated: true)
    }

}

private extension MovieDetailTableViewController {

    func configureNavigationBar() {
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.backgroundColor = UIColor(
            red: 40/255,
            green: 43/255,
            blue: 56/255,
            alpha: 1.0
        )
        navigationBarAppearance.shadowColor = UIColor(
            red: 40/255.0,
            green: 43/255.0,
            blue: 56/255.0,
            alpha: 1.0
        )

        navigationController?.navigationBar.standardAppearance = navigationBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navigationBarAppearance

        navigationController?.navigationBar.tintColor = .white
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
        tableView.rowHeight = UITableView.automaticDimension

        let nib = UINib(
            nibName: MovieDetailInfoTableViewCell.identifier,
            bundle: nil
        )
        tableView.register(
            nib,
            forCellReuseIdentifier: MovieDetailInfoTableViewCell.identifier
        )
    }

    func configureHierarchy() {
        configureNavigationBar()
        configureTableHeaderView()
        configureTableView()
    }

}

extension UIViewController {

    func configureNavigationBar_default() {
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.backgroundColor = .systemBackground
        navigationBarAppearance.shadowColor = .systemBackground

        navigationController?.navigationBar.standardAppearance = navigationBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navigationBarAppearance

        navigationController?.navigationBar.tintColor = .black
    }

}
