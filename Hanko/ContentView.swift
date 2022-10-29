//
//  ContentView.swift
//  Hanko
//
//  Created by Lukas Romsicki on 2022-10-29.
//

import SwiftUI

struct ContentView: View {
    @State var splitViewVisibility: NavigationSplitViewVisibility = .automatic
    @State var activeSection: AppSection = .keys(scope: .public)

    @StateObject var keyStore = KeyStore()

    @State var searchText: String = ""

    var body: some View {
        NavigationSplitView(columnVisibility: $splitViewVisibility) {
            Sidebar(activeSection: $activeSection)
                .navigationSplitViewColumnWidth(min: 200, ideal: 200, max: 250)
        } content: {
            if case let .keys(scope) = activeSection {
                KeyList(scope: scope, searchText: $searchText)
                    .navigationSplitViewColumnWidth(min: 500, ideal: 500)
                    .navigationTitle(scope.description)
            }
        } detail: {
            KeyDetails.Placeholder()
        }
        .environmentObject(keyStore)
        .searchable(text: $searchText, placement: .sidebar, prompt: "Search")
    }
}
