//
//  SliderViewModel.swift
//  Patterns
//
//  Created by 김효원 on 23/09/2019.
//  Copyright © 2019 HyowonKim. All rights reserved.
//

import Foundation

protocol SliderViewModelProtocol: class {
    //view 상태
    var number: String? { get }
    var value: Float? { get }
    init(slider:Slider)
    
    // 값변환기
    var sliderDidChange: ((SliderViewModelProtocol) -> ())? { get set }
    var textFieldDidChange: ((SliderViewModelProtocol) -> ())? { get set }
    
     // 명령
    func showNumber(number: Int)
    func showSlider(value: Int)
}

class SliderViewModel: SliderViewModelProtocol {
    
    var slider: Slider
    
    var number: String? {
        didSet {
            self.sliderDidChange?(self)
        }
    }
    var value: Float? {
        didSet {
            self.textFieldDidChange?(self)
        }
    }
    
    var sliderDidChange: ((SliderViewModelProtocol) -> ())?
    var textFieldDidChange: ((SliderViewModelProtocol) -> ())?
    
    required init(slider: Slider) {
        self.slider = slider
    }
    
    func showNumber(number: Int) {
        slider.number = number
        self.number = "\(number)"
    }
    
    func showSlider(value: Int) {
        slider.number = value
        self.value = Float(value)
    }
}
