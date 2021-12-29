//
//  SidebarViewModel.swift
//  Hanko
//
//  Created by Lukas Romsicki on 2021-12-28.
//

import Combine
import Foundation

enum AppSection: Equatable {
    case allKeys
    case secretKeys
}

class SidebarViewModel: ObservableObject {
    @Published var currentSection: AppSection? = .allKeys

    @Published var allKeys: [PrimaryKey] = []
    @Published var secretKeys: [PrimaryKey] = []

    func loadKeys() {
        let secretKeys = retrieveSecretKeys()
        let allKeys = retrieveAllKeys(secretKeys: secretKeys)

        self.secretKeys = secretKeys
        self.allKeys = allKeys
    }

    private func retrieveAllKeys(secretKeys: [PrimaryKey]) -> [PrimaryKey] {
        let task = GPGTask(arguments: ["--list-keys", "--with-colons"])
        let taskResult = task.run()
        let recordPayload = RecordPayload(from: taskResult.output)

        let allKeys = recordPayload
            .recordSet
            .recordSets(of: [.publicKey])
            .compactMap { try? PrimaryKey(from: $0) }

        return allKeys.map { key in
            secretKeys.first { $0.fingerprint == key.fingerprint } ?? key
        }
    }

    private func retrieveSecretKeys() -> [PrimaryKey] {
        let task = GPGTask(arguments: ["--list-secret-keys", "--with-colons"])

        let taskResult = task.run()
        let recordPayload = RecordPayload(from: taskResult.output)

        return recordPayload
            .recordSet
            .recordSets(of: [.secretKey])
            .compactMap { try? PrimaryKey(from: $0) }
    }
}
