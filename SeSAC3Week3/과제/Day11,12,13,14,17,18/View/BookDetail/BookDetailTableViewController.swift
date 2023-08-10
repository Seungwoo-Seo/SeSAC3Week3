//
//  MovieDetailTableViewController.swift
//  SeSAC3Week3
//
//  Created by 서승우 on 2023/07/31.
//

import UIKit

final class BookDetailTableViewController: UITableViewController {
    static let identifier = "BookDetailTableViewController"

    var book: Book?
    weak var delegate: BookDetailTableViewHeaderDelegate?

    @IBOutlet weak var tableHeaderView: BookDetailTableViewHeader!

    override func viewDidLoad() {
        super.viewDidLoad()

        configureHierarchy()
    }

}

extension BookDetailTableViewController {

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
        let cell = tableView.dequeueReusableCell(
            withIdentifier: BookDetailInfoTableViewCell.identifier,
            for: indexPath
        ) as! BookDetailInfoTableViewCell

        cell.configure(book: book)

        return cell
    }

}

extension BookDetailTableViewController: BookDetailTableViewHeaderDelegate {

    func cancelTheLike(movie: Movie?) {}

    func didTapBackButton() {
        dismiss(animated: true)
    }

}

private extension BookDetailTableViewController {

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
//        tableHeaderView.frame.size.height = 120
        tableHeaderView.homeDelegate = delegate
        tableHeaderView.detailDelegate = self
        tableHeaderView.book = book

        if navigationController != nil {
            tableHeaderView.configure()
        } else {
            tableHeaderView.configure(isHidden: false)
        }
    }

    func configureTableView() {
        tableView.rowHeight = UITableView.automaticDimension

        let nib = UINib(
            nibName: BookDetailInfoTableViewCell.identifier,
            bundle: nil
        )
        tableView.register(
            nib,
            forCellReuseIdentifier: BookDetailInfoTableViewCell.identifier
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
