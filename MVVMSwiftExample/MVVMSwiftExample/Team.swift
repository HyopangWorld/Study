//
//  Team.swift
//  MVVMExample
//
//  Created by Dino Bartosak on 15/09/16.
//  Copyright © 2016 Toptal. All rights reserved.
//
// 팀 이름과 플레이어 목록을 포함합니다.(각 팀은 3명의 플레이어가 있습니다)

import Foundation

class Team: NSObject {
    
    let identifier: String
    var name: String
    var players: [Player]
    
    init(name: String, identifier: String) {
        self.name = name
        self.identifier = identifier
        self.players = []
    }
    
    func addPlayer(_ player: Player) {
        self.players.append(player)
    }

    func containsPlayer(_ player: Player) -> Bool {
        var contains: Bool = false
        for currentPlayer in players {
            if currentPlayer.identifier == player.identifier {
                contains = true
                break
            }
        }
        
        return contains
    }
    
}
