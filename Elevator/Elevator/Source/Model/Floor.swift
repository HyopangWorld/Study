//
//  Person.swift
//  Elevator
//
//  Created by 김효원 on 10/09/2019.
//  Copyright © 2019 HyowonKim. All rights reserved.
//

import Foundation

class Floor: Subject {
    var id: Int
    private var count_: Int = 0
    var count: Int {
        set {
            self.count_ = newValue
            self.notifyObserver()
        }
        get {
            return self.count_
        }
    }
    
    private var state_: State = .up
    var state: State {
        set {
            self.state_ = newValue
            self.notifyObserver()
        }
        get {
            return self.state_
        }
    }

    init(id: Int) {
        self.id = id
    }
    
    
    func notifyObserver(){
        for observer in observers {
            observer.update(data: self)
        }
    }
}

extension Floor {
    enum State: Int{
        case up
        case down
    }
}


