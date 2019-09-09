//
//  Model.swift
//  ObserverTest
//
//  Created by 김효원 on 09/09/2019.
//  Copyright © 2019 HyowonKim. All rights reserved.
//

import Foundation


class Calculator: Observeration {
    private var number: Int = 0
    var num: Int {
        set{
            number = newValue
            notify()
        }
        get{
            return number
        }
    }
    
    func notify(){
        for observer in observers {
            observer.update(self.number)
        }
    }
}

class Binary: Observer {
    var calculator: Calculator
    var number: Int32 = 0
    
    init(calculator: Calculator) {
        self.calculator = calculator
        self.calculator.addObserver(self)
    }
    
    func update(_ value: Any?) {
        number = (String(calculator.num, radix: 2) as NSString).intValue
    }
}

class Hex: Observer {
    var calculator: Calculator
    var number: Int32 = 0
    
    init(calculator: Calculator) {
        self.calculator = calculator
        self.calculator.addObserver(self)
    }
    
    func update(_ value: Any?) {
        number = (String(calculator.num, radix: 16) as NSString).intValue
    }
}

class Octal: Observer {
    var calculator: Calculator
    var number: Int32 = 0
    
    init(calculator: Calculator) {
        self.calculator = calculator
        self.calculator.addObserver(self)
    }
    
    func update(_ value: Any?) {
        number = (String(calculator.num, radix: 8) as NSString).intValue
    }
}

