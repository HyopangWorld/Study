//
//  ViewModel.swift
//  Patterns
//
//  Created by 김효원 on 18/09/2019.
//  Copyright © 2019 HyowonKim. All rights reserved.
//

import Foundation

protocol ViewModelProtocol: class {
    var hi: String? { get }
    var hiDidChange: ((ViewModelProtocol) -> ())? { get set }
    init(person: Person)
    func sayHi()
}

class ViewModel: ViewModelProtocol {
    let person: Person
    var hi: String? {
        didSet {
            self.hiDidChange?(self)
        }
    }
    
    var hiDidChange: ((ViewModelProtocol) -> ())?
    
    required init(person: Person) {
        self.person = person
    }
    
    func sayHi() {
        self.hi = self.person.toString()
    }
}
