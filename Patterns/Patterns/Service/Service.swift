//
//  Service.swift
//  Patterns
//
//  Created by 김효원 on 18/09/2019.
//  Copyright © 2019 HyowonKim. All rights reserved.
//

import Foundation

class SayHiService {
    func getPersonInfo(name: String, callBack:(Person?) -> Void){
        let people = [Person(age: 20, name: "김효원"),
                      Person(age: 23, name: "김정원"),
                      Person(age: 17, name: "김승연"),
        ]
        
        if let foundPerson = people.first(where: {$0.name == name}){
            callBack(foundPerson)
        } else {
            callBack(nil)
        }
    }
}

protocol PersonSayHiDelegate: NSObjectProtocol {
    func displaySayHi(description: String)
}
