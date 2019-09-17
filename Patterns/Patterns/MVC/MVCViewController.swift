//
//  MVCViewController.swift
//  Patterns
//
//  Created by 김효원 on 17/09/2019.
//  Copyright © 2019 HyowonKim. All rights reserved.
//

import UIKit

class MVCViewController: UIViewController {
    @IBOutlet weak var label: UILabel!
    let service = SayHiService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func didTapHyowon(_ sender: UIButton) {
        showLabelText(name: "김효원")
    }
    
    @IBAction func didTapJeongwon(_ sender: Any) {
        showLabelText(name: "김정원")
    }
    
    @IBAction func didTapSeongyun(_ sender: Any) {
        showLabelText(name: "김승연")
    }
    
    // delegate 없이 서비스 이용
    func showLabelText(name: String) {
        
        service.getPersonInfo(name: name) { person in
            label.text = person?.toString()
        }
    }
}
