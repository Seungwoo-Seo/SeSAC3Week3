//
//  DiaryTableViewController.swift
//  SeSAC3Week3
//
//  Created by 서승우 on 2023/07/31.
//

import UIKit

final class DiaryTableViewController: UITableViewController {

    var list = [
    "테스트1테스트1테스트1테스트1테스트1테스트1테스트1테스트1테스트1테스트1테스트1테스트1테스트1테스트1테스트1테스트1테스트1테스트1테스트1테스트1테스트1테스트1테스트1테스트1테스트1테스트1테스트1테스트1테스트1테스트1테스트1테스트1테스트1테스트1",
    "테스트2테스트2테스트2테스트2테스트2테스트2테스트2테스트2테스트2테스트2테스트2테스트2테스트2테스트2테스트2테스트2테스트2테스트2테스트2테스트2",
    "테스트3테스트3테스트3테스트3테스트3테스트3테스트3테스트3테스트3테스트3테스트3테스트3테스트3테스트3"
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        setBackgroundColor()
    }

    override func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        return list.count
    }

    override func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: DiaryTableViewCell.identifier,
            for: indexPath
        ) as? DiaryTableViewCell

        let row = list[indexPath.row]
        cell?.configureCell(row: row)

        return cell ?? UITableViewCell()
    }

    override func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        let vc = storyboard?.instantiateViewController(
            withIdentifier: "AddViewController"
        ) as! AddViewController

        vc.type = .edit
        vc.contents = list[indexPath.row]

//        // 값 전달 시 아웃렛을 활용할 수 는 없음!
//        // error -
//        vc.contentsLabel.text = list[indexPath.row]
//        // -
        navigationController?.pushViewController(
            vc,
            animated: true
        )
    }

    @IBAction func didTapSearchBarButtonItem(_ sedner: UIBarButtonItem) {
        let sb = UIStoryboard(name: "Diary", bundle: nil)
        let vc = sb.instantiateViewController(
            withIdentifier: "SearchCollectionViewController"
        ) as! SearchCollectionViewController

        navigationController?.pushViewController(
            vc,
            animated: true
        )
    }


    @IBAction func didTapAddBarButtonItem(_ sender: UIBarButtonItem) {
        let sb = UIStoryboard(name: "Diary", bundle: nil)
        let vc = sb.instantiateViewController(
            withIdentifier: "AddViewController"
        ) as! AddViewController

        vc.type = .add

        // nav를 사용한다면, present와 화면 전환 방식도 nav로 수정 해주어야 함
        let nav = UINavigationController(rootViewController: vc)
//        nav.modalTransitionStyle = .crossDissolve
        nav.modalPresentationStyle = .fullScreen

        present(nav, animated: true)
    }

}
