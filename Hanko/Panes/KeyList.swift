//
//  KeyList.swift
//  Hanko
//
//  Created by Lukas Romsicki on 2021-12-26.
//

import GPGKit
import SwiftUI

enum KeyListScope {
    case all
    case secret
}

struct KeyList: View {
    @ObservedObject private var viewModel = KeyListViewModel()

    var items: [Key]

    var body: some View {
        List(items, id: \.fingerprint) { key in
            NavigationLink(
                destination: KeyDetails(key: key, didDelete: {
                    viewModel.delete(key: key)
                }),
                tag: key,
                selection: $viewModel.selectedKey
            ) {
                KeyListItem(key: key)
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
                    viewModel.delete(key: key)
                }

                if key.isSecret {
                    Button("Delete Only Secret Key…", action: {})
                }
            }
        }
        .frame(minWidth: 400, minHeight: 400)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                Button(action: {}) {
                    Image(systemName: "square.and.arrow.down")
                }
                .help("Import an existing key")
            }

            ToolbarItem(placement: .primaryAction) {
                Button(action: viewModel.presentNewKeySheet) {
                    Image(systemName: "plus")
                }
                .keyboardShortcut("N", modifiers: .command)
                .help("Create a new key")
            }
        }
        .sheet(isPresented: $viewModel.newKeySheetVisible) {
            NewKeySheet(sheetVisible: $viewModel.newKeySheetVisible)
        }
    }

    struct Placeholder: View {
        var body: some View {
            EmptyView()
        }
    }
}
