//
//  LottoViewController.swift
//  SeSAC3Week3
//
//  Created by 서승우 on 2023/08/03.
//

import UIKit

final class LottoViewController: UIViewController {

    var list = Array(1...1000) //.reversed()  //Array(repeating: "A", count: 10)

    @IBOutlet weak var textField: UITextField!
    let pickerView = UIPickerView()

    override func viewDidLoad() {
        super.viewDidLoad()


        // 깜박이 숨기는 방법
        textField.tintColor = .clear

        textField.inputView = pickerView
        configureHierarchy()
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

