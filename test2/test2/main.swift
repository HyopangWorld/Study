//
//  main.swift
//  test2
//
//  Created by 김효원 on 04/07/2019.
//  Copyright © 2019 김효원. All rights reserved.
//

import Foundation

/* 함수 */
func hello1(name: String, time: Int) -> String {
    var string = ""
    for _ in 0..<time{
        string += "\(name)님 안녕하세요!\n"
    }
    return string
}
print(hello1(name: "김효원", time: 2))

/* 1. 함수 호출 시 사용하는 파라미터 이름과 함수 내부 이름을 다르게 사용할 때 */
func a(to name: String, numberOfTimes time: Int){
    for _ in 0..<time{
        print("\(name)님 안녕하세요!")
    }
}
a(to: "김효원", numberOfTimes: 2)

/* 2. 파라미터 이름 생략하기 */
func b(_ name: String, time: Int){}
b("김효원", time: 2)

/* 3. 파라미터 기본 값 지정하기, 호출 시 생략 가능 */
func c(name: String, time: Int = 1){}
c(name: "김효원", time: 1)
c(name: "김효원")

/* 4. 개수가 정해지지 않은 파라미터(Variadic Parameter) 받기 */
func d(_ numbers: Int...) -> Int{
    var sum = 0
    for number in numbers {
        sum += number
    }
    return sum
}
print(d(1,2))
print(d(4,3,3,6,7,5))

/* 5-1. 함수 속의 함수 */
func hello2(name: String, time: Int){
    func message(name: String) -> String{
        return "\(name)님 안녕하세요! 5-1"
    }
    
    for _ in 0..<time{
        print(message(name : name))
    }
}
hello2(name: "김효원", time: 3)

/* 5-2. 함수 속의 함수를 반환하기 */
// -> (String) -> String : String을 받아 String으로 반환하는 함수
func helloGenerator(message: String) -> (String) -> String{ // (2) 함수 호출
    func hello3(name: String) -> String{ //(5) 내부 함수 호출
        return name+message //(6) 최종반환
    }
    return hello3 //(3) 함수 반환
}
let hello3 = helloGenerator(message: "님 안녕하세요! 5-2") //(1) 호출
print(hello3("김효원")) //(4) 반환 받은 내부 함수 호출

// -> (String, String) -> String
func helloGenerator2(message: String) -> (String, Int) -> String {
    func hello4(name: String, age: Int) -> String {
        return name+message+String(age)
    }
    return hello4
}
let hello4 = helloGenerator2(message: "님의 나이는 : ")
print(hello4("김효원", 20))

/*------------------------------------------------------------------------*/
/* Closure */
// : 함수를 간결히 표현하는 실행 가능한 코드 블럭을 말함
func helloClosure(message: String) -> (String, Int) -> String{
    return { (name: String, age: Int) -> String in
        return name+message+String(age)
    }
}
let closure1 = helloClosure(message: "(1)님의 나이는")
print(closure1("김효원", 20))

// 더 간결하게 생략 해보자
func helloClosure2(message: String) -> (String, Int) -> String {
    return { name, age in
        return name+message+String(age)
    }
}
let closure2 = helloClosure(message: "(2)님의 나이는")
print(closure2("김효원", 20))

// 더 더 간결하게 생략 해보자
func helloClosure3(message: String) -> (String, Int) -> String {
    return {
        return $0 + message + String($1)
    }
}
let closure3 = helloClosure(message: "(3)님의 나이는")
print(closure3("김효원", 20))

// 안의 코드 가 한줄일 경우, 더 더 더 간결하게
func helloClosure4(message: String) -> (String, Int) -> String {
    return { $0 + message + String($1) }
}
let closure4 = helloClosure(message: "(4)님의 나이는")
print(closure4("김효원", 20))

// 더 더 더 더 간결하게
let closure5: (String, Int) -> String = { $0 + "(5)님의 나이는" + String($1) }
print(closure5("김효원", 20))

// Optional로 정의하기
let closure6: ((String, Int) -> String)? = { $0 + "(6)님의 나이는" + String($1) }
print(closure6?("김효원", 20) ?? "default")

// Closure 파라미터로 받기
func manipulate(number: Int, using block: (Int) -> Int) -> Int {
    return block(number)
}

print(manipulate(number: 10, using: { (number: Int) -> Int in
    return number * 2
}))

// 더 생략해보자
print(manipulate(number: 10, using: {$0 * 2}))

// 함수의 마지막 파라미터가 클로저일 경우, 더 더 생략해보자
print(manipulate(number: 10){ $0 * 2 })

// 위의 형태로 이루어진 sort
var numbers = [1,3,2,6,7,5,8,4]
let sortedNumbers = numbers.sort { $0 < $1 }  // 왜 이렇게 나와요? 왜 얘만 () 로 나오지...
print(numbers)

// 위의 형태로 이루어진 filter
let evens = numbers.filter { $0 % 2 == 0 }
print(evens) //2,4,6,8

// 클로저 활용하기 - map
// : 파라미터로 받은 클로저를 모든 요소에 실행하고 그 결과를 반환한다.
let arr1 = [1, 3, 6, 2, 7, 9]
let arr2 = arr1.map{ $0 * 2 } // 모든 인자 값에 * 2 를 한 값 반환
print(arr2)

// 클로저 활용하기 - reduce
// : 초기값과 첫번째 요소의 클로저의 실행 결과, 그 결과와 두번째 요소의 클로저 실행 결과 ... 그 결과와 n번째 요소의 클로저 실행 결과의 값을 반환
let arr3 = arr1.reduce(0) { $0 + $1 } // 초기값:0, ((((0+1)+3)+4)...n)
print(arr3)

// Swift에서는 연산자 == 함수 == 클로저 이다. 따라서 1+2를 하면 + 연산자가 실행됨.
// 파라미터로는 1과 2가 넘겨짐. 즉, '+' 함수 == { $0 + $1 } == arr.reduce(0, +) 가 성립한다.
let arr4 = arr1.reduce(0, +)
print(arr4)

/*------------------------------------------------------------------------*/

/*  */
