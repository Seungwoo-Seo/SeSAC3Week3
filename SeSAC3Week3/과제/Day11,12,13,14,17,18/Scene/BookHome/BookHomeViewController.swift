//
//  BookHomeViewController.swift
//  SeSAC3Week3
//
//  Created by 서승우 on 2023/07/31.
//

import Alamofire
import RealmSwift
import SwiftyJSON
import UIKit

final class BookHomeViewController: BaseViewController {
    // MARK: - View
    lazy var searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: self.resultsTableViewController)
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "찾고 싶은 영화를 검색하세요."

        return searchController
    }()
    lazy var resultsTableViewController: UITableViewController = {
        let tableViewController = UITableViewController()
        tableViewController.tableView.dataSource = self
        tableViewController.tableView.delegate = self
        tableViewController.tableView.register(
            UITableViewCell.self,
            forCellReuseIdentifier: "Cell"
        )

        return tableViewController
    }()
    @IBOutlet var rootView: BookHomeRootView!

    // MARK: - Data
    var bookList: [Book] = [] {
        didSet {
            rootView.collectionView.reloadData()
        }
    }
    var searchBookList: [Book] = [] {
        didSet {
            resultsTableViewController.tableView.reloadData()
        }
    }
    var isSearch = false // 검색인지 아닌지 확인

    var tasks: Results<RMBook>!

    // MARK: - Override
    override func viewDidLoad() {
        super.viewDidLoad()

        let realm = try! Realm()
        tasks = realm.objects(RMBook.self).sorted(byKeyPath: "date", ascending: false)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        configureNavigationBar_default()
        navigationController?.navigationBar.prefersLargeTitles = true

        rootView.collectionView.reloadData()
    }

    override func initalConfigure() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "고래밥님의 책장"
        navigationItem.backButtonTitle = ""
        navigationItem.searchController = searchController
        rootView.collectionView.dataSource = self
        rootView.collectionView.delegate = self
    }

    // MARK: - Event
    @objc
    func didTapLikeButton(_ sender: UIButton) {
        sender.toggle
//        movies[sender.tag].like = sender.isSelected
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    }

}

extension BookHomeViewController: UICollectionViewDataSource {

    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return tasks.count
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: BookCollectionViewCell.identifier,
            for: indexPath
        ) as! BookCollectionViewCell

        let book = tasks[indexPath.row]
        cell.configure(book: book)

        // MARK: 다시
//        cell.likeButton.addTarget(
//            self,
//            action: #selector(didTapLikeButton),
//            for: .touchUpInside
//        )
//        cell.likeButton.tag = indexPath.row

        return cell
    }

}

extension BookHomeViewController: UICollectionViewDelegate {

    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        let book = bookList[indexPath.item]
        pushToBookDetailViewController(book: book)
    }

}

extension BookHomeViewController: UISearchResultsUpdating {

    func updateSearchResults(
        for searchController: UISearchController
    ) {
        // 1. 서치바에서 검색을 한다면
        // 2. 검색한 데이터들을 담을 공간이 필요
        // 3. 해당 공간에 있는 데이터들을 기준으로 테이블 뷰를 업데이트
        isSearch = true
        fetchData(query: searchController.searchBar.text!)
    }

}

extension BookHomeViewController: UISearchBarDelegate {

    func searchBarSearchButtonClicked(
        _ searchBar: UISearchBar
    ) {
        pushToBookSearchViewController(
            searchText: searchBar.text
        )
    }

    func searchBarCancelButtonClicked(
        _ searchBar: UISearchBar
    ) {
        restorationToBooks()
        searchBar.resignFirstResponder()
    }

}

extension BookHomeViewController: UITableViewDataSource {

    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        return searchBookList.count
    }

    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "Cell",
            for: indexPath
        )

        let searchBook = searchBookList[indexPath.row]
        cell.textLabel?.text = searchBook.title

        return cell
    }

}

extension BookHomeViewController: UITableViewDelegate {

    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        let book = searchBookList[indexPath.row]
        var authros: List<String> = List()
        book.authors.forEach { authros.append($0) }

        let realm = try! Realm()
        let task = RMBook(
            title: book.title,
            content: book.description,
            originalPrice: book.originalPrice,
            salePrice: book.salePrice,
            thumbnail: book.thumbnail,
            datetime: book.datetime,
            authors: authros
        )

        try! realm.write {
            realm.add(task)
            print("Realm add")
        }
    }

}

extension BookHomeViewController: BookDetailTableViewHeaderDelegate {

    func cancelTheLike(movie: Movie?) {
//        if let index = movies.firstIndex(where: { $0.title == movie?.title }) {
//            movies[index].like.toggle()
//
//            let cell = collectionView.cellForItem(
//                at: IndexPath(row: index, section: 0)
//            ) as! MovieCollectionViewCell
//
//            cell.likeButton.toggle
//        }
    }

    func didTapBackButton() {}

}

// 동작
private extension BookHomeViewController {

    func pushToBookDetailViewController(book: Book) {
        let vc = storyboard?.instantiateViewController(
            withIdentifier: BookDetailTableViewController.identifier
        ) as! BookDetailTableViewController

        vc.book = book

        navigationController?.pushViewController(
            vc,
            animated: true
        )
    }

    func pushToBookSearchViewController(
        searchText: String?
    ) {
        let vc = storyboard?.instantiateViewController(
            withIdentifier: BookSearchViewController.identifier
        ) as! BookSearchViewController

        vc.searchText = searchText

        navigationController?.pushViewController(
            vc,
            animated: true
        )
    }

}

// 네트워킹
private extension BookHomeViewController {

    func fetchData(query: String?) {
        guard let query = query else {return}
        var components = URLComponents()
        components.scheme = "https"
        components.host = "dapi.kakao.com"
        components.path = "/v3/search/book"
        components.queryItems = [
            URLQueryItem(name: "query", value: query)
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
        var bookList: [Book] = []

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

            bookList.append(book)
        }

        // 검색이라면
        if isSearch {
            self.searchBookList = bookList
        } else {
            self.bookList = bookList
        }
    }

}

// 비즈니스
private extension BookHomeViewController {

    func searchToBook(text: String?) {
        guard let searchText = text?.lowercased()
        else {return}

        guard !(searchText
            .trimmingCharacters(in: .whitespaces)
            .isEmpty)
        else {
            restorationToBooks()
            return
        }

        isSearch = true
        searchBookList.removeAll()

        for book in bookList {
            let title = book.title.lowercased()
            if title.contains(searchText) {
                searchBookList.append(book)
            }
        }

        rootView.collectionView.reloadData()
    }

    func restorationToBooks() {
        isSearch = false
        searchBookList.removeAll()
        searchController.searchBar.text = ""
        rootView.collectionView.reloadData()
    }

}


