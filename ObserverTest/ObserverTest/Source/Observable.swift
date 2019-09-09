//
//  Observerable.swift
//  ObserverTest
//
//  Created by 김효원 on 09/09/2019.
//  Copyright © 2019 HyowonKim. All rights reserved.
//

import Foundation

// Observer 등록 Protocol
protocol Observable {
    func addObserver(_ observer: Observer)
    func removeObserver(_ observer: Observer)
}

// Observer Protocol
protocol Observer: class {
    func update(_ value: Any?)
}

// Observer를 등록하는 곳
class Observeration: Observable {
    var observers = [Observer]()
    
    func addObserver(_ observer: Observer) {
        observers.append(observer)
    }
    
    func removeObserver(_ observer: Observer) {
        observers = observers.filter({ $0 !== observer })
    }
}
