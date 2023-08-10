//
//  BookSearchViewController.swift
//  SeSAC3Week3
//
//  Created by 서승우 on 2023/07/31.
//

import Alamofire
import SwiftyJSON
import UIKit

final class BookSearchViewController: UIViewController {
    static let identifier = "BookSearchViewController"

    @IBOutlet weak var tableView: UITableView!

    var bookList: [Book] = []
    var searchText: String?
    var currentPage = 1

    override func viewDidLoad() {
        super.viewDidLoad()

        configureHierarchy()

        guard let query = searchText else {return}
        fetchData(query: query, page: currentPage)
    }

}

extension BookSearchViewController: UITableViewDataSource {

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
            withIdentifier: BookSearchTableViewCell.identifier,
            for: indexPath
        ) as! BookSearchTableViewCell

        let book = bookList[indexPath.row]
        cell.configure(book: book)

        return cell
    }
}

extension BookSearchViewController: UITableViewDelegate {

    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {

    }

}

extension BookSearchViewController: UITableViewDataSourcePrefetching {

    func tableView(
        _ tableView: UITableView,
        prefetchRowsAt indexPaths: [IndexPath]
    ) {
        for indexPath in indexPaths {
            if bookList.count - 1 == indexPath.row && currentPage < 50 {
                guard let query = searchText else {return}
                currentPage += 1
                fetchData(query: query, page: currentPage)
            }
        }
    }
}

// UI
private extension BookSearchViewController {

    func configureNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.tintColor = .black
        navigationItem.title = searchText
    }

    func configureTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.prefetchDataSource = self
        tableView.rowHeight = UITableView.automaticDimension

        let nib = UINib(
            nibName: BookSearchTableViewCell.identifier,
            bundle: nil
        )
        tableView.register(
            nib,
            forCellReuseIdentifier: BookSearchTableViewCell.identifier
        )
    }

    func configureHierarchy() {
        configureNavigationBar()
        configureTableView()
    }

}

// Network
private extension BookSearchViewController {

    func fetchData(query: String, page: Int) {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "dapi.kakao.com"
        components.path = "/v3/search/book"
        components.queryItems = [
            URLQueryItem(name: "query", value: query),
            URLQueryItem(name: "page", value: "\(page)")
        ]

        let headers: HTTPHeaders = [
            "Authorization": APIKey.kakao
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
        for book in json["documents"].arrayValue {
            let authors = book["authors"].arrayValue.map { $0.stringValue }
            let description = book["contents"].stringValue
            let datetime = book["datetime"].stringValue
            let originalPrice = book["price"].intValue
            let salePrice = book["sale_price"].intValue
            let thumbnail = book["thumbnail"].stringValue
            let title = book["title"].stringValue

            let book = Book(
                title: title,
                description: description,
                originalPrice: originalPrice,
                salePrice: salePrice,
                thumbnail: thumbnail,
                datetime: datetime,
                authors: authors
            )

            self.bookList.append(book)
        }

        tableView.reloadData()
    }

}
