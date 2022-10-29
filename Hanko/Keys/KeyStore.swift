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
    @Published var loading: Bool = false
    @Published var keys: [Key] = []

    func loadKeys(scope: KeyListScope) {
        loading = true

        var keyListModes: [KeyListMode] = []

        if scope == .secret {
            keyListModes.append(.withSecret)
        }

        let context = GPGContext(keyListModes: keyListModes)
        keys = context.keys(secret: scope == .secret)

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.loading = false
        }
    }

    func delete(key: Key) {
        let context = GPGContext()
        context.deleteKey(key: key, allowSecret: true)
    }

    func create(name: String) {
        let context = GPGContext(protocol: .openPGP, armor: true, offline: true)

        context.createKey(userId: name, algorithm: "RSA", expiresOn: Date().addingTimeInterval(10000), flags: [.sign, .certify])
    }
}
