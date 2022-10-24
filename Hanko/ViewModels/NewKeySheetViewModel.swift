//
//  NewKeySheetViewModel.swift
//  Hanko
//
//  Created by Lukas Romsicki on 2021-12-28.
//

import Combine
import Foundation
import GPGKit

class NewKeySheetViewModel: ObservableObject {
    @Published var name: String = ""

    func createKey() {
        let context = GPGContext(protocol: .openPGP, armor: true, offline: true)

        context.createKey(userId: name, algorithm: "RSA", expiresOn: Date().addingTimeInterval(10000), flags: [.sign, .certify])

//        let key = context.keys(matching: name).first!

//        context.createSubkey(key: key, algorithm: "RSA", expiresOn: .distantFuture, flags: [.authenticate])
//
//        context.addUserId(key: key, userId: "Test Person <test@romsicki.com>")
//        context.setUserIdFlag(key: key, userId: "Test Person <test@romsicki.com>", named: "email", withValue: "hello@me.com")

        print(context.keys(matching: name))

        NotificationCenter.default.post(name: .onUpdateKeys, object: nil)
    }
}
