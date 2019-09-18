//
//  MVVMViewController.swift
//  Patterns
//
//  Created by 김효원 on 18/09/2019.
//  Copyright © 2019 HyowonKim. All rights reserved.
//

import UIKit

class MVVMViewController: UIViewController {
    @IBOutlet weak var label: UILabel!
    
    var viewModel: ViewModel! {
        didSet {
            self.viewModel.hiDidChange = { [unowned self] viewModel in
                self.label.text = viewModel.hi
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func seongyunButtonDidTap(_ sender: Any) {
        viewModel.sayHi()
    }
    
    @IBAction func jeongwonButtonDidTap(_ sender: Any) {
        viewModel.sayHi()
    }
    
    @IBAction func hyowonButtonDidTap(_ sender: Any) {
        viewModel.sayHi()
        
    }
}
