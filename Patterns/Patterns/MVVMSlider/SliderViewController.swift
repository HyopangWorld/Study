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
            self.viewModel.sliderDidChange = {[unowned self] viewModel in
                self.numberTextField.text = viewModel.number
            }
            self.viewModel.textFieldDidChange = {[unowned self] viewModel in
                self.slider.value = viewModel.value!
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    
    @IBAction func sliderDidValueChange(_ sender: UISlider) {
        viewModel.showNumber(number: Int(sender.value))
    }
    
    @IBAction func numberTextFieldDidEditEnd(_ sender: UITextField) {
        if !checkValidation(sender.text) {
            sender.text = "0"
        }
        
        viewModel.showSlider(value: (sender.text! as NSString).integerValue)
    }
    
}

extension SliderViewController {
    
    func checkValidation(_ text: String?) -> Bool {
        guard let text = text else {
            return false
        }
        
        if text.isEmpty || text.rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) != nil {
            return false
        }
        
        if !((text as NSString).floatValue <= slider.maximumValue) {
            return false
        }
        
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
