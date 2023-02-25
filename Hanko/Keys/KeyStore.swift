//
//  KeyStore.swift
//  Hanko
//
//  Created by Lukas Romsicki on 2022-10-29.
//

import GPGKit
import SwiftUI

@MainActor
final class KeyStore: ObservableObject {
    @Published var keys: [Key] = []

    func loadKeys(scope: KeyListScope) {
        Task.detached { @MainActor in
            var keyListModes: [KeyListMode] = []

            if scope == .secret {
                keyListModes.append(.withSecret)
            }

            let context = GPGContext(keyListModes: keyListModes)
            self.keys = context.keys(secret: scope == .secret)
        }
    }

    func delete(key: Key) {
        let context = GPGContext()
        context.deleteKey(key: key, allowSecret: true)
    }

    func create(configuration: KeyGenerationConfiguration) {
        let context = GPGContext(protocol: .openPGP, armor: false, offline: true)

        context.generateKey(params: configuration.stringRepresentation)
    }
}
