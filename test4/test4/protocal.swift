//
//  protocal.swift
//  test4
//
//  Created by 김효원 on 05/07/2019.
//  Copyright © 2019 김효원. All rights reserved.
//

import Foundation

/* protocal */
//정의만 한다. 인터페이스 개념, 추상클래스처럼 쓸 수 있음

//프로토콜이 프로토콜 적용시킬 수 있음
protocol Messagable {
    var message: String? { get }
}

protocol Sendable : Messagable {
    var from: String? { get }
    var to: String { get }
    
    func send()
}

//구조체에 적용시키기
struct Mail: Sendable {
    var message: String?
    
    var from: String?
    var to: String
    
    func send() {
        print("Send a mail from \(String(describing: self.from)) to \(self.to)")
    }
}

struct Feedback: Sendable {
    var message: String?
    
    var from: String? {
        return nil // 피드백은 무조건 익명으로 보냅니다.
    }
    var to: String
    
    func send() {
        print("Send a feedback to \(self.to)")
    }
}

//프로토콜은 추상 클래스처럼 사용가능하다.
func sendAnything(_ sendable: Sendable) {
    sendable.send()
}

struct Letter : Sendable {
    var message: String?
    var from: String?
    
    var to: String
    
    func send() {
    }
}

