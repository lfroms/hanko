//
//  HankoApp.swift
//  Hanko
//
//  Created by Lukas Romsicki on 2021-12-25.
//

import Foundation
import GPGKit
import SwiftUI

@main
struct HankoApp: App {
    init() {
        setenv("PATH", "/opt/homebrew/bin", 1)

        let engine = GPGEngine()
        engine.checkVersion()
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .frame(minWidth: 800, minHeight: 300)
        }
        .windowStyle(.titleBar)
        .windowToolbarStyle(.unified(showsTitle: true))
        .defaultSize(width: 1000, height: 550)
        .defaultPosition(.center)
    }
}
