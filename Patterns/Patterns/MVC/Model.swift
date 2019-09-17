//
//  Model.swift
//  Patterns
//
//  Created by 김효원 on 17/09/2019.
//  Copyright © 2019 HyowonKim. All rights reserved.
//

import Foundation

class Person {
    let age: Int
    let name: String
    
    init(age: Int, name: String){
        self.age = age
        self.name = name
    }
    
    func toString() -> String{
        return "안녕하세요. 제 이름은 \(name)이고, 나이는 \(age)입니다."
    }
}
