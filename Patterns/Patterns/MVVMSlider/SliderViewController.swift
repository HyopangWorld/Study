//
//  SliderViewController.swift
//  Patterns
//
//  Created by 김효원 on 23/09/2019.
//  Copyright © 2019 HyowonKim. All rights reserved.
//

import UIKit

class SliderViewController: UIViewController {
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var numberTextField: UITextField!
    
    var viewModel: SliderViewModel! {
        didSet {
            self.viewModel.numberDidChange = {[unowned self] viewModel in
                self.numberTextField.text = viewModel.number
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    
    @IBAction func sliderDidValueChange(_ sender: UISlider) {
        viewModel.showNumber(number: sender.value)
    }
    
}
