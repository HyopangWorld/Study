//
//  Observable.swift
//  Elevator
//
//  Created by 김효원 on 10/09/2019.
//  Copyright © 2019 HyowonKim. All rights reserved.
//

import Foundation


protocol Observable {
    func addObserver(observer: Observer)
    func removeObserver(observer: Observer)
}

protocol Observer: class {
    func update(data: Any)
}

class Subject: Observable {
    var observers = [Observer]()
    
    func addObserver(observer: Observer) {
        observers.append(observer)
    }
    
    func removeObserver(observer: Observer) {
        observers.removeAll()
    }
}
