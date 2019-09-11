//
//  Elevator.swift
//  Elevator
//
//  Created by 김효원 on 10/09/2019.
//  Copyright © 2019 HyowonKim. All rights reserved.
//

import Foundation


class Elavator: Subject, Observer {
    var curFloor: Int = 1
    var moveState: state = .stop
    
    var moveArray = Array<Floor>() {
        didSet {
            self.notifyObserver()
        }
    }
    
    func notifyObserver(){
        for observer in observers {
            observer.update(data: moveArray)
        }
    }
    
    func update(data: Any) {
        if !(data is Floor) {
            return
        }
        let floor = data as! Floor
        
        if moveArray.count <= 0 {
            moveArray.append(floor)
            return
        }
        
        switch floor.state {
        case .up:
            for move in moveArray {
                guard let index = moveArray.firstIndex(where: { $0.id == move.id }) else {
                    return
                }
                
                if move.state == .up && move.id > floor.id {
                    moveArray.insert(floor, at: index + 1)
                    return
                }
                
                if move.state == .down && moveArray.count - 1 <= index  {
                    moveArray.insert(floor, at: index + 1)
                    return
                }
            }
            
        case .down:
            for move in moveArray {
                if move.id < floor.id {
                    guard let index = moveArray.firstIndex(where: { $0.id == move.id }) else {
                        return
                    }
                    moveArray.insert(floor, at: index)
                    return
                }
            }
        }
    }
}

extension Elavator {
    enum state: String {
        case move
        case stop
    }
}
