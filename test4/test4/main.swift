//
//  main.swift
//  test4
//
//  Created by 김효원 on 05/07/2019.
//  Copyright © 2019 김효원. All rights reserved.
//

import Foundation

/* 튜플 */
// : 어떠한 값들의 묶음, 배열과 비슷하지만 다르게 길이가 고정되어있고, 접근할떄 '.' 사용
var coffeInfo = ("아메리카노", 5100)
print(coffeInfo.0)
print(coffeInfo.1)
coffeInfo.1 = 1300

//튜플 파라미터에 이름을 붙일 수 있음
var namedCoffeInfo = (coffee: "아메리카노", price: 5100)
print(namedCoffeInfo.coffee)
print(namedCoffeInfo.price)
namedCoffeInfo.price = 1300

//튜플 타입 어노테이션
var coffeeInfo: (String, Int)
var namedCoffeeInfo: (coffee: String, price: Int)

//여러 변수에 값을 지정할 수 있음
let (coffee, price) = ("아메리카노", 5100)
print(coffee)
print(price)

// _키워드를 사용해 파라미터를 무시할 수 있음.
let (_, latteSize, lattePrice) = ("라떼", "Venti", 5600)
print(latteSize)
print(lattePrice)

// 튜플을 반환하는 함수
// ex) 커피 이름에 맞는 커피 가격 정보를 반환, 일치하는 커피 이름이 없다면 'nil' 반환
func coffeeInfo(for name: String) -> (name: String, price: Int)? {
    let coffeeInfoList: [(name: String, price: Int)] = [
        ("아메리카노", 5100),
        ("라떼", 5600)
    ]
    
    for coffeeInfo in coffeeInfoList{
        if coffeeInfo.name == name {
            return coffeeInfo
        }
    }
    return nil
}

let americanoInfo = coffeeInfo(for: "아메리카노")
let latteInfo = coffeeInfo(for: "라떼")
print(americanoInfo!.name + "은 " + String(americanoInfo!.price) + "(원) 입니다." )
print(latteInfo!.name + "은 " + String(latteInfo!.price) + "(원) 입니다." )

/*-----------------------------------------------------------------------------*/

/* Enum */
enum Month: Int{
    case jan = 1 // 시작 원시값을 지정할 수 있다.
    case feb
    case mar
    case apr
    case may
    case jun
    case jul
    case aug // 8
    case sep = 15 // 원시값을 지정할 수 있음 (시작값 초기화) 뒷 숫자랑 겹치면 X
    case oct // 16
    case nov
    case dec
    
    func simpleDescription() -> String{
        switch self {
        case .jan:
            return "1월"
        case .feb:
            return "2월"
        case .mar:
            return "3월"
        case .apr:
            return "4월"
        case .may:
            return "5월"
        case .jun:
            return "6월"
        case .jul:
            return "7월"
        case .aug:
            return "8월"
        case .sep:
            return "9월"
        case .oct:
            return "10월"
        case .nov:
            return "11월"
        case .dec:
            return "12월"
        }
    }
}

let dec = Month.dec
print(dec)
print(dec.simpleDescription())
print(dec.rawValue)

//원시값으로 enum값 만들기
let jul = Month(rawValue: 7)
print(jul!) //jul // 옵셔널 처리를 왜 하지? -> Enum에서 정의되지 않은 원시값을 가지고 생성할 경우

//일반적인 프로그래밍 언어와는 달리 원시값을 String으로도 지정 가능
enum IssusState: String{
    case open = "open"
    case closed = "closed"
}

//원시 값이 없을 수 있음
enum Spoon{
    case dirt
    case bronze
    case silver
    case gold
    
    func simpleDescription() -> String {
        switch self {
        case .dirt:
            return "흙수저"
        case .bronze:
            return "동수저"
        case .silver:
            return "은수저"
        case .gold:
            return "금수저"
        }
    }
}

// enum을 예측 할 수 있다면 enum 이름 생략 가능
let spoon: Spoon = .gold  // 변수에 타입 어노테이션이 있기 때문에 가능
func doSomeThing(with spoon: Spoon){
    print(spoon.simpleDescription())
}
doSomeThing(with: .silver)

/* 연관 값(Associated Values)을 가지는 Enum */
enum NetworkError {
    case invalidParameter(String, String)
    case timeout
}

//값 넣기
let error: NetworkError = .invalidParameter("email", "이메일 형식이 올바르지 않습니다.")

//값 꺼내오기 - if
if case .invalidParameter(let field, let message) = error {
    print(field)
    print(message)
}

//값 꺼내오기 - switch~case
switch error {
case .invalidParameter(let field, let message) :
    print(field)
    print(message)
    
default:
    break
}

//옵셔널은 사실 Enum임

/*-----------------------------------------------------------------------------*/

/* protocal 호출 부분 .*/
var mail = Mail(message: "안뇽", from: "devxoul@gmail.com", to: "jeon@stylesha.re")
sendAnything(mail)

var feedback = Feedback(message: "안뇽", to: "devxoul@gmail.com")
sendAnything(feedback)

class Dog{
    var name: String?
    var age: Int?
}

/*-----------------------------------------------------------------------------*/

/* type casting */
let anyNumber: Any = 10
let anyString: Any = "Hi"

let anyInstance: AnyObject = Dog()
//anyNumber + 1 // 컴파일 에러! 10을 넣었다고 해서 Int type이 아니다
let number: Int? = anyNumber as? Int

if let number = anyNumber as? Int {
    print(number + 1)
}

print(anyNumber is Int)    // true
print(anyNumber is Any)    // true
print(anyNumber is String) // false
print(anyString is String) // true


/*-----------------------------------------------------------------------------*/

/* extention */
// : 이미 정의된 타입에 새로운 속성이나 메서드를 추가할 수 있다.
extension String {
    var length: Int {
        return self.count
    }
    
    func plusWord(word: String) -> String {
        return self.self + word
    }
}

let str = "안녕하세요"
print(str.length) // 5
print(str.plusWord(word: " 이것은 붙임 말입니다."))
