//
//  SliderViewModel.swift
//  Patterns
//
//  Created by 김효원 on 23/09/2019.
//  Copyright © 2019 HyowonKim. All rights reserved.
//

import Foundation

protocol SliderViewModelProtocol: class {
    var number: String? { get } //view 상태
    var numberDidChange: ((SliderViewModelProtocol) -> ())? { get set } // 값변환기
    init(slider:Slider)
    func showNumber(number:Float) // 명령
}

class SliderViewModel: SliderViewModelProtocol {
    var slider: Slider
    var number: String? {
        didSet {
            self.numberDidChange?(self)
        }
    }
    
    var numberDidChange: ((SliderViewModelProtocol) -> ())?
    
    required init(slider: Slider) {
        self.slider = slider
    }
    
    func showNumber(number: Float) {
        slider.number = number
        self.number = "\(self.slider.number)"
    }
}
