//
//  AudioPlayer.swift
//  MusicPlayer
//
//  Created by 김효원 on 09/09/2019.
//  Copyright © 2019 HyowonKim. All rights reserved.
//

import Foundation

class AudioPlayer {
    
    private var state = State.idle {
        didSet{stateDidChange()}
    }
    
    func play(_ item: Any){
        state = .playing(item)
    }
    
    func pause(){
        switch state {
        case .idle, .paused:
            break
        case .playing(_):
            state = .paused
        }
    }
    
    func stop(){
        state = .idle
    }
}

private extension AudioPlayer {
    enum State {
        case idle
        case playing(Any)
        case paused
    }
}

private extension AudioPlayer {
    func stateDidChange(){
        switch state {
        case .idle:
            break
        case .playing(let _):
            break
        case .paused:
            break
        }
    }
}
