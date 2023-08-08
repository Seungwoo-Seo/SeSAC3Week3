//
//  LottoViewController.swift
//  SeSAC3Week3
//
//  Created by 서승우 on 2023/08/03.
//

import Alamofire
import SwiftyJSON
import UIKit

final class LottoViewController: UIViewController {

    var list = Array(1...1000) //.reversed()  //Array(repeating: "A", count: 10)

    @IBOutlet weak var textField: UITextField!
    let pickerView = UIPickerView()
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var bonusNumberLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()


        let url = URL(string: "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=1079")!

        fetchData(value: 1078)



        // 깜박이 숨기는 방법
        textField.tintColor = .clear
        textField.inputView = pickerView

        configureHierarchy()
    }

    func fetchData(value: Int) {
//        var components = URLComponents(string: "https://www.dhlottery.co.kr/common.do")
        var components = URLComponents()
        components.scheme = "https"
        components.host = "dhlottery.co.kr"
        components.path = "/common.do"
        components.queryItems = [
            URLQueryItem(
                name: "method",
                value: "getLottoNumber"
            ),
            URLQueryItem(
                name: "drwNo",
                value: "1079"
            )
        ]

        guard let url = components.url
        else {
            print("?")
            return
        }

        print(url)

        AF
            .request(url, method: .get)
            .validate()
            .responseJSON { [weak self] (response) in
            guard let self
            else {return}

            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")

                let date = json["drwNoDate"].stringValue
                let bonusNumber = json["bnusNo"].intValue

                print("-----------")
                print(date, bonusNumber)
                print("-----------")

                self.dateLabel.text = date
                self.bonusNumberLabel.text = "\(bonusNumber)번"

            case .failure(let error):
                print(error)
            }
        }
    }

}

extension LottoViewController: UIPickerViewDataSource {

    func numberOfComponents(
        in pickerView: UIPickerView
    ) -> Int {
        return 3
    }

    func pickerView(
        _ pickerView: UIPickerView,
        numberOfRowsInComponent component: Int
    ) -> Int {
        return list.count
    }

}

extension LottoViewController: UIPickerViewDelegate {

    func pickerView(
        _ pickerView: UIPickerView,
        didSelectRow row: Int,
        inComponent component: Int
    ) {
        textField.text = "\(list[row])"
        print("select: \(row)")
    }

    func pickerView(
        _ pickerView: UIPickerView,
        titleForRow row: Int,
        forComponent component: Int
    ) -> String? {
        return "\(list[row])"
    }

}

private extension LottoViewController {

    func configurePickerView() {
        pickerView.dataSource = self
        pickerView.delegate = self
    }

    func configureHierarchy() {
        configurePickerView()
    }

}

