//
//  PlayerScoreboardMoveEditorViewModel.swift
//  MVVMSwiftExample
//
//  Created by 김효원 on 19/09/2019.
//  Copyright © 2019 Toptal. All rights reserved.
//

import Foundation

protocol PlayerScoreboardMoveEditorViewModel {
    var playerName: String { get }
    
    var onePointMoveCount: String { get }
    var twoPointMoveCount: String { get }
    var assistMoveCount: String { get }
    var reboundMoveCount: String { get }
    var foulMoveCount: String { get }
    
    func onePointMove()
    func twoPointMove()
    func assistMove()
    func reboundMove()
    func foulMove()
}

protocol PlayerScoreboardMoveEditorViewModelDelegate {
    func updateUI()
}
