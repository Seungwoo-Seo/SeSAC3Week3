//
//  MovieSearchViewController.swift
//  SeSAC3Week3
//
//  Created by 서승우 on 2023/07/31.
//

import Alamofire
import SwiftyJSON
import UIKit

final class MovieSearchViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    let searchBar = UISearchBar()

    var bookList: [Book] = [] {
        didSet {
            tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        configureHierarchy()
    }

}

private extension MovieSearchViewController {

    func configureNavigationBar() {
        navigationController?.navigationBar.tintColor = .black
        navigationItem.title = "검색 화면"
        let leftBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "xmark"),
            style: .plain,
            target: self,
            action: #selector(didTapleftBarButtonItem)
        )
        navigationItem.leftBarButtonItem = leftBarButtonItem
    }

    func configureSearchBar() {
        searchBar.delegate = self
        navigationItem.titleView = searchBar
    }

    func configureTableView() {
        tableView.dataSource = self
        tableView.delegate = self
    }

    func configureHierarchy() {
        configureNavigationBar()
        configureSearchBar()
        configureTableView()
    }

}

extension MovieSearchViewController: UISearchBarDelegate {

    func searchBar(
        _ searchBar: UISearchBar,
        textDidChange searchText: String
    ) {
        let query = searchText.trimmingCharacters(
            in: .whitespaces
        )
        fetchData(query: query)
    }

}

extension MovieSearchViewController: UITableViewDataSource {

    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        return bookList.count
    }

    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "Cell",
            for: indexPath
        )

        cell.textLabel?.text = bookList[indexPath.row].title

        return cell
    }
}

extension MovieSearchViewController: UITableViewDelegate {


}

private extension MovieSearchViewController {

    @objc
    func didTapleftBarButtonItem(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }

}

// Networking
private extension MovieSearchViewController {

    func fetchData(query: String) {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "dapi.kakao.com"
        components.path = "/v3/search/book"
        components.queryItems = [
            URLQueryItem(name: "query", value: query)
        ]

        let headers: HTTPHeaders = [
            "Authorization": "KakaoAK eb0e63cce021a13f3ed449c8209b547d"
        ]

        guard let url = components.url else {return}

        AF
            .request(url, method: .get, headers: headers)
            .validate()
            .responseJSON { [weak self] (response) in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    self?.updateJSON(json)

                case .failure(let error):
                    print(error)
                }
            }
    }

    func updateJSON(_ json: JSON) {
        var bookList: [Book] = []

        for book in json["documents"].arrayValue {
            let authors = book["authors"].arrayValue.map { $0.stringValue }
            let description = book["contents"].stringValue
            let datetime = book["datetime"].stringValue
            let price = book["sale_price"].intValue
            let thumbnail = book["thumbnail"].stringValue
            let title = book["title"].stringValue

            let book = Book(
                title: title,
                description: description,
                price: price,
                thumbnail: thumbnail,
                datetime: datetime,
                authors: authors
            )

            bookList.append(book)
        }

        self.bookList = bookList
    }

}
