//
//  Sidebar.swift
//  Hanko
//
//  Created by Lukas Romsicki on 2021-12-26.
//

import SwiftUI

struct Sidebar: View {
    @Binding var activeSection: AppSection

    var body: some View {
        List(selection: $activeSection) {
            Section("Keys") {
                NavigationLink(value: AppSection.keys(scope: .public)) {
                    Label("Public", systemImage: "globe.americas.fill")
                        .tint(.teal)
                }

                NavigationLink(value: AppSection.keys(scope: .secret)) {
                    Label("Secret", systemImage: "lock.fill")
                        .tint(.pink)
                }
            }
        }
    }
}
