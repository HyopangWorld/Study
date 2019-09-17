//
//  ViewController.swift
//  Patterns
//
//  Created by 김효원 on 17/09/2019.
//  Copyright © 2019 HyowonKim. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MVC
        let model = Person(age: 10, name: "김효원")
        let vc = MVCViewController()
        vc.person = model
        
        present(vc, animated: true, completion: nil)
    }
}

