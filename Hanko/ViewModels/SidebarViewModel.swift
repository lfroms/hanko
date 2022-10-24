//
//  SidebarViewModel.swift
//  Hanko
//
//  Created by Lukas Romsicki on 2021-12-28.
//

import Combine
import Foundation
import GPGKit

enum AppSection: Equatable {
    case allKeys
    case secretKeys
}

class SidebarViewModel: ObservableObject {
    @Published var currentSection: AppSection? = .allKeys

    @Published var allKeys: [Key] = []
    @Published var secretKeys: [Key] = []

    func loadKeys() {
        let context = GPGContext()
        self.allKeys = context.keys(secret: false)
        self.secretKeys = context.keys(secret: true)
    }
}
