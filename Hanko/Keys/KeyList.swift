//
//  KeyList.swift
//  Hanko
//
//  Created by Lukas Romsicki on 2021-12-26.
//

import SwiftUI

struct KeyList: View {
    @EnvironmentObject var keyStore: KeyStore
    @State var newKeySheetVisible: Bool = false

    let scope: KeyListScope

    var body: some View {
        List(keyStore.keys, id: \.self) { key in
            NavigationLink {
                KeyDetails(key: key)
                    .id(key.keyListMode)
            } label: {
                KeyListItem(key: key)
                    .id(key.keyListMode)
            }
            .contextMenu {
                Button("Export…", action: {})
                Divider()
                Button("Copy Fingerprint", action: {
                    let pasteboard = NSPasteboard.general
                    pasteboard.declareTypes([.string], owner: nil)
                    pasteboard.setString(key.fingerprint, forType: .string)
                })
                Divider()
                Button("Delete…") {
                    keyStore.delete(key: key)
                }

                if key.isSecret {
                    Button("Delete Only Secret Key…", action: {})
                }
            }
        }
        .toolbar {
            ToolbarItemGroup {
                if keyStore.loading {
                    ProgressView()
                        .progressViewStyle(.circular)
                        .scaleEffect(0.5)
                }

                Button(action: {}) {
                    Image(systemName: "square.and.arrow.down")
                }
                .help("Import an existing key")

                Button {
                    keyStore.loadKeys(scope: scope)
                } label: {
                    Image(systemName: "arrow.clockwise")
                }
                .help("Refresh")
                .keyboardShortcut("R", modifiers: [.command])

                Button {
                    newKeySheetVisible.toggle()
                } label: {
                    Image(systemName: "plus")
                }
                .keyboardShortcut("N", modifiers: .command)
                .help("Create a new key")
            }
        }
        .sheet(isPresented: $newKeySheetVisible) {
            NewKeySheet(sheetVisible: $newKeySheetVisible)
        }
        .onChange(of: scope) { newScope in
            keyStore.loadKeys(scope: newScope)
        }
        .task {
            keyStore.loadKeys(scope: scope)
        }
    }
}
