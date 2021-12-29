//
//  GPGTask.swift
//  Hanko
//
//  Created by Lukas Romsicki on 2021-12-27.
//

struct GPGTask {
    private(set) var arguments: [String]

    init(arguments: [String]) {
        self.arguments = arguments
    }

    mutating func add(argument: String) {
        arguments.append(argument)
    }

    func run(standardInput: String? = nil) -> Result {
        return gpg(arguments, standardInput: standardInput)
    }

    private func gpg(_ arguments: [String], standardInput: String? = nil) -> Result {
        // TODO: Don't hardcode this path.
        shell(launchPath: "/usr/local/bin/gpg", arguments: arguments, standardInput: standardInput)
    }
}
