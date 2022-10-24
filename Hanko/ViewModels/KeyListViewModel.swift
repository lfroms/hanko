//
//  KeyListViewModel.swift
//  Hanko
//
//  Created by Lukas Romsicki on 2021-12-27.
//

import Combine
import Foundation
import GPGKit

class KeyListViewModel: ObservableObject {
    @Published var selectedKey: Key?

    @Published var newKeySheetVisible: Bool = false

    func presentNewKeySheet() {
        newKeySheetVisible = true
    }

    func delete(key: Key) {
        let context = GPGContext()
        context.deleteKey(key: key, allowSecret: true)

        NotificationCenter.default.post(name: .onUpdateKeys, object: nil)
    }
}
