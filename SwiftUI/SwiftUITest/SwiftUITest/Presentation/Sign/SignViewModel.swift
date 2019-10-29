//
//  SignViewModel.swift
//  SwiftUITest
//
//  Created by 김효원 on 2019/10/29.
//  Copyright © 2019 HyowonKim. All rights reserved.
//

import SwiftUI
import Combine

class SignViewModel: ObservableObject {
    @Published var name: String = ""
    
    private var cancellables = Set<AnyCancellable>()
    
    init(scheduler: DispatchQueue = DispatchQueue(label: "SignViewModel"){
        _ = Just(nil)
            .sink(receiveValue: getBeers(page:))
    }
}
