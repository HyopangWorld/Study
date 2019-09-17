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
        
        // MARK: - MVC
        let vc = MVCViewController()
        present(vc, animated: true, completion: nil)
        
        // MARK: - MVP
//        let vc = MVPViewController()
//        let presenter = MVPPresenter(service: SayHiService())
//        vc.presenter = presenter
//
//        present(vc, animated: true, completion: nil)
    }
}

