//
//  SearchCollectionViewController.swift
//  SeSAC3Week3
//
//  Created by 서승우 on 2023/07/31.
//

import UIKit

final class SearchCollectionViewController: UICollectionViewController {

    let searchBar = UISearchBar()

    let list = ["iOS", "iPad", "Android", "Apple", "Watch", "사과", "사자"]
    var searchList: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        let nib = UINib(
            nibName: "SearchCollectionViewCell",
            bundle: nil
        )

        collectionView.register(
            nib,
            forCellWithReuseIdentifier: SearchCollectionViewCell.identifier
        )

        setCollectionViewLayout()

        configureHierarchy()
    }

    //
    func setCollectionViewLayout() {
        let spacing: CGFloat = 16.0

        let width = (UIScreen.main.bounds.width - spacing * 4) / 3
        let height = width

        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = spacing
        layout.minimumLineSpacing = spacing
        layout.scrollDirection = .vertical
        layout.sectionInset = .init(
            top: spacing,
            left: spacing,
            bottom: spacing,
            right: spacing
        )
        layout.itemSize = CGSize(
            width: width,
            height: height
        )

        collectionView.collectionViewLayout = layout
    }

    override func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return searchList.count
    }

    override func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: SearchCollectionViewCell.identifier,
            for: indexPath
        ) as? SearchCollectionViewCell

        cell?.backgroundColor = .brown
        cell?.contentsLabel.text = searchList[indexPath.item]

        return cell ?? UICollectionViewCell()
    }

    override func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {

    }

}

extension SearchCollectionViewController: UISearchBarDelegate {

    func searchBarSearchButtonClicked(
        _ searchBar: UISearchBar
    ) {
        searchingText()
    }

    func searchBarCancelButtonClicked(
        _ searchBar: UISearchBar
    ) {
        searchList.removeAll()
        searchBar.text = ""
        collectionView.reloadData()
    }

    func searchBar(
        _ searchBar: UISearchBar,
        textDidChange searchText: String
    ) {
        searchingText()
    }

}

private extension SearchCollectionViewController {

    func configureSearchBar() {
        searchBar.delegate = self
        searchBar.placeholder = "검색어를 입력해주세요"
        searchBar.showsCancelButton = true
        navigationItem.titleView = searchBar
    }

    func configureHierarchy() {
        configureSearchBar()
    }

}

private extension SearchCollectionViewController {

    func searchingText() {
        guard let searchBarText = searchBar.text?.lowercased()
        else {return}

        searchList.removeAll()

        list.forEach {
            let standard = $0.lowercased()
            if standard.contains(searchBarText) {
                searchList.append($0)
            }
        }

        collectionView.reloadData()
    }

}
