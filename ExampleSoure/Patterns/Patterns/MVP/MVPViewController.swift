//
//  MVPViewController.swift
//  Patterns
//
//  Created by 김효원 on 17/09/2019.
//  Copyright © 2019 HyowonKim. All rights reserved.
// Passive View

import UIKit

class MVPViewController: UIViewController, PersonSayHiDelegate {
    var presenter: MVPPresenter!
    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.setViewDelegate(personSayHiDelegate: self)
    }
    
    // 유저 액션을 Presenter로
    @IBAction func didTapHyowon(_ sender: UIButton) {
        presenter.showLabelText(name: "김효원")
    }
    
    @IBAction func didTapJeongwon(_ sender: Any) {
        presenter.showLabelText(name: "김정원")
    }
    
    @IBAction func didTapSeongyun(_ sender: Any) {
        presenter.showLabelText(name: "김승연")
    }
    
    func displaySayHi(description: String) {
        self.label.text = description
    }
}
