//
//  TestViewController.swift
//  SeSAC3Week3
//
//  Created by 서승우 on 2023/08/09.
//

import UIKit

final class TestViewController: UIViewController {

    var testList = [
        "asdfasdfas",
        "asdfasdfas",
        "asdfasdfas",
        "asdfasdfas",
        "asdfasdfas",
        "asdfasdfas",
        "asdfasdfas",
        "asdfasdfas"
    ]

    var searchController = UISearchController()
    var resultsTableViewController = UITableViewController()

    override func viewDidLoad() {
        super.viewDidLoad()

        configureHierarchy()
    }

}

extension TestViewController: UITableViewDataSource {

    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        return testList.count
    }

    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        cell.textLabel?.text = testList[indexPath.row]

        return cell
    }

}

extension TestViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        dismiss(animated: true)
    }

}

extension TestViewController: UISearchResultsUpdating {

    func updateSearchResults(
        for searchController: UISearchController
    ) {
        print("????")
    }

}

extension TestViewController: UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBarCancelButtonClicked(searchBar)
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }

}

extension TestViewController: UISearchControllerDelegate {

}

private extension TestViewController {

    func configureNavigationBar() {
        navigationItem.title = "BookWarm"
        navigationController?.navigationBar.prefersLargeTitles = true
        definesPresentationContext = true
    }

    func configureTest() {
        searchController = UISearchController(searchResultsController: resultsTableViewController)

        navigationItem.searchController = searchController
//        테이블 뷰의 헤더에 서치바를 넣느다고?
//        tableView.tableHeaderView = searchController.searchBar

        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.delegate = self

        resultsTableViewController.tableView.dataSource = self
        resultsTableViewController.tableView.delegate = self
    }


    func configureHierarchy() {
        resultsTableViewController.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")

        configureNavigationBar()
        configureTest()
    }

}

