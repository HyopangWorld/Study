//
//  ViewController.swift
//  ObserverTest
//
//  Created by 김효원 on 09/09/2019.
//  Copyright © 2019 HyowonKim. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var binaryLabel: UILabel!
    @IBOutlet weak var hexLabel: UILabel!
    @IBOutlet weak var octalLabel: UILabel!
    
    @IBOutlet weak var textFiled: UITextField!
    
    var calculator = Calculator()
    var b: Binary!
    var h: Hex!
    var o: Octal!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        b = Binary(calculator: calculator)
        h = Hex(calculator: calculator)
        o = Octal(calculator: calculator)
    }
    
    @IBAction func sendDidTap(_ sender: Any) {
        guard let text = textFiled.text else {
            return
        }
        
        if !text.isEmpty && text.rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) == nil {
            calculator.num = (text as NSString).integerValue
            binaryLabel.text = "\(b.number)"
            hexLabel.text = "\(h.number)"
            octalLabel.text = "\(o.number)"
        }
    }
}

