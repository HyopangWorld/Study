//
//  main.swift
//  test3
//
//  Created by 김효원 on 05/07/2019.
//  Copyright © 2019 김효원. All rights reserved.
//

import Foundation

/* Class와 Struct */
class Dog {
    var name: String?
    var age: Int?
    
    func simpleDescription() -> String {
        if let name = self.name {
            return "갱얼쥐 이름: \(name)"
        } else {
            return "no name"
        }
    }
}

struct Coffee {
    var name: String?
    var size: String?
    
    func simpleDescription() -> String {
        if let name = self.name {
            return "커피 이름: \(name)"
        } else {
            return "커피 이름 없음"
        }
    }
}

var myDog = Dog()
myDog.name = "뽀삐"
print(myDog.simpleDescription())

var myCoffee = Coffee()
myCoffee.name = "아메리카노"
myCoffee.size = "Venti"
print(myCoffee.simpleDescription())

//1. class 상속이 가능, 구조체는 불가능
class Animal {
    var type: String?
}

class Cat : Animal {
    var name: String?
    var age: Int?
}

var myCat = Cat()
myCat.type = "포유류"
print(myCat.type ?? "동물")

//2. 클래스는 reference(참조), 구조체는 copy(복사)한다.
var dog1 = Dog() // dog1은 Dog 객체 참조
var dog2 = dog1 // dog2는 dog1의 참조 값을 가져와 똑같은 Dog 객체 참조
dog1.name = "바둑이"
print(dog2.name ?? "갱얼쥐") //바둑이

var americano = Coffee() // americano는 Coffee 객체 그 자체
var cafucino = americano // americano 값 자체를 복사한다.
americano.size = "venti"
print(cafucino.size ?? "커피") //nil => 커피 출력

//3. 생성자
class Bird : Animal {
    var name: String?
    var age: Int?
    var color: String // optional 타입이 아니고, 초기값 지정이 되어있지 않으면 compil err
    var legNum = 2 // 초기값 지정 방식1 - 정의할때
    
    override init(){
        self.color = "red" // 초기값을 모든 생성자에서 지정
        super.init()
        self.type = "조류" // 여기서부터 상위 클래스의 self 접근 가능
    }
    
    init(age: Int){
        self.age = age
        self.color = "blue" // 초기값 지정 방식2 - 생성자에서 지정
    }
    
    deinit{
        print("메모리 해체 시 호출")
    }
}

struct Juice {
    var name: String?
    var size: String?
    
    init(name: String, size: String){ // 파라미터가 있는 생성자
        self.size = size
        self.name = name
    }
}

//4. 속성
// (1) Stored Property : 값을 가지는 속성 (일반 데이터를 가지는 속성)
// (2) Computed Property : 계산되는 속성 (어떠한 연상을 수행한 뒤 그 결과를 반환하는 속성, get, set을 사용에서 정의)
struct Hex{
    var decimal: Int?  // Stored Property
    var hexString: String?{  // 1. Computed Property
        get{
            if let decimal = self.decimal{
                return String(decimal, radix: 16) // 16진수로 변환해서 문자형으로 반환
            } else {
                return nil
            }
        }
        set{
            if let newValue = newValue {
                self.decimal = Int(newValue, radix:16) // 16진수로 변환해서 정수형으로 반환
            } else {
                self.decimal = nil
            }
        }
    }
    
    //2. get만 정의 할떄는 키워드 생략가능
    var hexCode: String?{
        if let hex = self.hexString{
            return "0x" + hex
        }
        return nil
    }
    
    // 3. willSet과 didSet
    // : 어떤 속성 값이 지정되기 직전과 직후에 원하는 코드 실행 가능. UI 업데이트 혹은 특정메서드 호출하는데 쓰임.
    var decimal2: Int = 0 {
        willSet{
            print("\(String(describing: self.decimal2))에서 \(String(describing: newValue))로 값이 바뀔 예정입니다.")
        }
        didSet{
            print("\(String(describing: oldValue))에서 \(String(describing: self.decimal2))로 값이 바뀌었습니다.")
        }
    }
}

var hex = Hex()
hex.decimal = 10
print(hex.hexString ?? "nil")  // a

hex.hexString = "b"
print(hex.decimal ?? "nil") // 11

print("hexCode : " + hex.hexCode!)

hex.decimal2 = 10
hex.decimal2 = 5




