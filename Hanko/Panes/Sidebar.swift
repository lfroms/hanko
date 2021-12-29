//
//  Sidebar.swift
//  Hanko
//
//  Created by Lukas Romsicki on 2021-12-26.
//

import SwiftUI

extension NSNotification.Name {
    static let onUpdateKeys = Notification.Name("onUpdateKeys")
}

struct Sidebar: View {
    @ObservedObject private var viewModel = SidebarViewModel()

    // TODO: We're loading all the data in advance anyways, so make a separate view model for the key loading.

    var body: some View {
        List {
            NavigationLink(
                destination: KeyList(items: viewModel.allKeys)
                    .navigationTitle("All Keys"),
                tag: AppSection.allKeys,
                selection: $viewModel.currentSection
            ) {
                Label("All Keys", systemImage: "key.fill")
            }

            NavigationLink(
                destination: KeyList(items: viewModel.secretKeys)
                    .navigationTitle("Secret Keys"),
                tag: AppSection.secretKeys,
                selection: $viewModel.currentSection
            ) {
                Label("Secret Keys", systemImage: "lock.fill")
            }
        }
        .listStyle(SidebarListStyle())
        .listItemTint(.red)
        .frame(minWidth: 220)
        .onAppear(perform: viewModel.loadKeys)
        .onReceive(NotificationCenter.default.publisher(for: .onUpdateKeys)) { _ in
            viewModel.loadKeys()
        }
    }
}
