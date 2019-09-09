//
//  NotificationCenterName.swift
//  MusicPlayer
//
//  Created by 김효원 on 09/09/2019.
//  Copyright © 2019 HyowonKim. All rights reserved.
//

import Foundation

extension Notification.Name {
    static var playbackStarted: Notification.Name {
        return .init("AudioPlayer.playbackStarted")
    }
    
    static var playbackPaused: Notification.Name {
        return .init("AudioPlayer.playbackPaused")
    }
    
    static var playbackStopped: Notification.Name {
        return .init("AudioPlayer.playbackStopped")
    }
}
