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
        let mvc = MVCViewController()
        
        // MVP
        let mvp = MVPViewController()
        let presenter = MVPPresenter(service: SayHiService())
        mvp.presenter = presenter
        
        // MVVM
        let mvvvm = MVVMViewController()
        let model = Person(age: 20, name: "김효원")
        let viewModel = ViewModel(person: model)
        mvvvm.viewModel = viewModel
        
        present(mvvvm, animated: true, completion: nil)
    }
}

