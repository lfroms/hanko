//
//  Shell.swift
//  Hanko
//
//  Created by Lukas Romsicki on 2021-12-27.
//

import Foundation

func shell(launchPath path: String, arguments args: [String], standardInput: String? = nil) -> Result {
    // TODO: Make asynchronous so that the UI isn't blocked.
    let task = Process()
    task.launchPath = path
    task.arguments = args

    if let standardInput = standardInput {
        let input = Pipe()
        task.standardInput = input

        try? input.fileHandleForWriting.write(contentsOf: standardInput.data(using: .utf8)!)
        try? input.fileHandleForWriting.close()
    }

    let pipe = Pipe()
    task.standardOutput = pipe
    task.standardError = pipe
    task.launch()

    let data = pipe.fileHandleForReading.readDataToEndOfFile()
    let output = String(data: data, encoding: .utf8)

    task.waitUntilExit()

    return Result(exitCode: Int(task.terminationStatus), output: output!)
}

struct Result {
    let exitCode: Int
    let output: String
}
