import UIKit

var greeting = "Hello, playground"

struct BMI {


    var nickname: String {
        willSet {
            newValue
        }
        didSet {
            oldValue
            print("유저 닉네임 변경 완료")
        }

    }

    var weight: Double
    var height: Double

    var BMIResult: String {
        get {
            let bmiValue = weight / (height * height)
            let bmiStatus = bmiValue < 18.5 ? "저체중" : "정상 이상"

            return "\(nickname)님의 BMI 지수는 \(bmiValue)로 \(bmiStatus)입니다."
        }
        set {
            nickname = newValue
        }
    }
}

var bmi = BMI(nickname: "고래밥", weight: 70, height: 1.8)
bmi.BMIResult = "칙촉"


class FoodRestaurant {
    let name = "잭치킨"

    var totalOrderCount = 10

    var newOrder : Int {
        get {
            return totalOrderCount  * 5000
        }
        set {
            totalOrderCount += newValue
        }
    }
}

class TypeFoodRestaurant {
    static let name = "젝치킨ㅋ"

    static var totaOrederCOunt = 10

    static var newOrder: Int {
        get {
            return totaOrederCOunt * 5000
        }
        set {
            totaOrederCOunt += newValue
        }
    }
}

class Coffee {
    static var name = "아메리카노"
    static var shot = 2

    class func plusShot() {
        shot += 1
    }
}

class Latte: Coffee {

    override static func plusShot() {

    }
}

// 실질적인 구현(내용)은 클래스, 열거형, 구조체 등에서 이루어짐
// 선택적 요청(Optional Requirement) : 구현 객체에 따라 필요하지 않은 요소가 존재할 수 있어서, 이를 방지하기 위해 옵셔널 형태로 지정할 수 있음
@objc
protocol ViewPresentableProtocol {
    // 최소 요구 사항으로, get만 할 수도 있고 set도 할 수 있음
    // 변수명만 같으면 상관 없이, 저장 프로퍼티로 구현해도 되고 연산 프로퍼티로 구현해도 됨
    var navigationTitle: String {get}
    var backgroundColor: UIColor {get}

    func configureView()
    func configureLabel()
    @objc optional func configureTextField()
}

class A: UIViewController, ViewPresentableProtocol {
    var navigationTitle: String = "검색 화면"
    var backgroundColor: UIColor = .red

    func configureView() {

    }

    func configureLabel() {

    }

    func configureTextField() {

    }



}

class B: UIViewController, ViewPresentableProtocol {
    var navigationTitle: String  {
        return ""
    }
    var backgroundColor: UIColor {
        get {
            return .red
        }
    }

    func configureView() {

    }

    func configureLabel() {

    }

    func configureTextField() {

    }



}

class C: UIViewController {
}
