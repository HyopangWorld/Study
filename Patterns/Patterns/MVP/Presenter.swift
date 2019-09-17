//
//  Presenter.swift
//  Patterns
//
//  Created by 김효원 on 17/09/2019.
//  Copyright © 2019 HyowonKim. All rights reserved.
//
// view가 model에 대해 알기 원치 않기 때문에, 현재 VC를 모아서 동작시키지 않고 다른 곳에서 동작
// iOS에서 MVP는 테스트 하기엔 좋지만 코드가 길어진다.

import Foundation


// view는 껍데기
protocol MVPView: class {
    func setLabelText(text: String)
}

// 정보를 뿌려주는 역할
protocol Presenter {
    init(service: SayHiService)
    func showLabelText(name: String)
}

class MVPPresenter: Presenter {
    private let service: SayHiService
    weak private var personSayHiDelegate: PersonSayHiDelegate?
    
    // model을 소유 및 갱신
    required init(service: SayHiService) {
        self.service = service
    }
    
    // delgate 등록
    func setViewDelegate(personSayHiDelegate: PersonSayHiDelegate){
        self.personSayHiDelegate = personSayHiDelegate
    }
    
    // view에 뿌려주기 (view 갱신)
    func showLabelText(name: String) {
        
        // service를 호출하고
        service.getPersonInfo(name: name) { [weak self] person in
            // Present에서 view를 가지고 있지 않고, delegate에 위임
            if let person = person {
                self?.personSayHiDelegate?.displaySayHi(description: person.toString())
            }
        }
    }
}
