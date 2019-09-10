//
//  ViewController.swift
//  Elevator
//
//  Created by 김효원 on 10/09/2019.
//  Copyright © 2019 HyowonKim. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var personView: UIView!
    @IBOutlet var elevatorView: UIView!
    @IBOutlet weak var curPerson: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let elve = Elavator()
        elve.addObserver(observer: self)
        
        var floor = Array<Floor>()
        for i in 0...7 {
            let fl = Floor(id: i)
            fl.addObserver(observer: elve)
            floor.append(fl)
        }
        
        floor[2].state = .down
        floor[5].state = .down
        floor[6].state = .down
    }
}

extension ViewController: Observer {
    func update(data: Any) {
        if !(data is Array<Floor>) {
            return
        }
        let moveArray = data as! Array<Floor>
        
        var text = ""
        for move in moveArray {
            text += "-> \(move.id)층"
        }
        
        curPerson.text = text
    }
}
