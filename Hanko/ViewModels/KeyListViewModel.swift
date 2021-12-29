//
//  KeyListViewModel.swift
//  Hanko
//
//  Created by Lukas Romsicki on 2021-12-27.
//

import Combine
import Foundation

class KeyListViewModel: ObservableObject {
    @Published var selectedKey: PrimaryKey?

    @Published var newKeySheetVisible: Bool = false

    func presentNewKeySheet() {
        newKeySheetVisible = true
    }

    func delete(key: PrimaryKey) {
        let task = GPGTask(arguments: ["--delete-secret-and-public-key", "--batch", key.fingerprint])
        _ = task.run()

        NotificationCenter.default.post(name: .onUpdateKeys, object: nil)
    }
}
