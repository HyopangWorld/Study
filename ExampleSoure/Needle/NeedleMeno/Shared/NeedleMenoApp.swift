//
//  NeedleMenoApp.swift
//  Shared
//
//  Created by 와이오엘오 on 2022/06/29.
//

import SwiftUI

import NeedleFoundation

@main
struct NeedleMenoApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
