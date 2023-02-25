//
//  KeyList.swift
//  Hanko
//
//  Created by Lukas Romsicki on 2021-12-26.
//

import GPGKit
import SwiftUI

struct KeyList: View {
    @EnvironmentObject var keyStore: KeyStore
    @State var newKeySheetVisible: Bool = false

    let scope: KeyListScope
    @Binding var searchText: String

    var body: some View {
        List(filteredKeys, id: \.fingerprint) { key in
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
        .onAppear {
            keyStore.loadKeys(scope: scope)
        }
    }

    var filteredKeys: [Key] {
        guard !searchText.isEmpty else {
            return keyStore.keys
        }

        return keyStore.keys.filter { key in
            let uidInfo = key.uids.flatMap { uid in
                [uid.email, uid.name, uid.comment]
            }

            let details = ([key.fingerprint] + uidInfo).map { $0.lowercased() }

            return details.contains { $0.contains(searchText.lowercased()) }
        }
    }
}
