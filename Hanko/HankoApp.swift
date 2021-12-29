//
//  HankoApp.swift
//  Hanko
//
//  Created by Lukas Romsicki on 2021-12-25.
//

import Foundation
import SwiftUI

@main
struct HankoApp: App {
    @State var loading = false

    var body: some Scene {
        WindowGroup {
            NavigationView {
                Sidebar()
                    .toolbar {
                        ToolbarItem(placement: .navigation) {
                            Button(action: toggleSidebar) {
                                Image(systemName: "sidebar.leading")
                            }
                        }
                    }

                KeyList.Placeholder()
                KeyDetails.Placeholder()
            }
        }
        .commands {
            SidebarCommands()
        }
        .windowStyle(.titleBar)
        .windowToolbarStyle(.unified(showsTitle: true))
    }

    private func toggleSidebar() {
        NSApp.keyWindow?.firstResponder?.tryToPerform(#selector(NSSplitViewController.toggleSidebar(_:)), with: nil)
    }
}
