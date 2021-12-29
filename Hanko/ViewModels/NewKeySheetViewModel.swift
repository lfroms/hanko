//
//  NewKeySheetViewModel.swift
//  Hanko
//
//  Created by Lukas Romsicki on 2021-12-28.
//

import Combine
import Foundation

class NewKeySheetViewModel: ObservableObject {
    @Published var name: String = ""

    func createKey() {
        let task = GPGTask(arguments: ["--batch", "--gen-key"])

        let newKeyOperation = NewKeyOperation(
            keyType: "default",
            subkeyType: "default",
            name: name,
            comment: "test key",
            email: "joe@foo.bar",
            expirationDate: "0",
            askPassphrase: true
        )

        _ = task.run(standardInput: newKeyOperation.stringRepresentation)

        NotificationCenter.default.post(name: .onUpdateKeys, object: nil)
    }
}
