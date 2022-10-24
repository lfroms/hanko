//
//  EngineInfo.swift
//  GPGKit
//
//  Created by Lukas Romsicki on 2022-10-23.
//

import gpgme

public struct EngineInfo {
    let `protocol`: `Protocol`
    let fileName: String
    let version: String
    let minimumVersion: String
    let homeDirectory: String?
}

extension EngineInfo {
    init(from raw: gpgme_engine_info_t) {
        let pointee = raw.pointee

        self.protocol = .init(from: pointee.protocol)
        self.fileName = String(cString: pointee.file_name)
        self.version = String(cString: pointee.version)
        self.minimumVersion = String(cString: pointee.req_version)

        if let homeDirectory = pointee.home_dir {
            self.homeDirectory = String(cString: homeDirectory)
        } else {
            self.homeDirectory = nil
        }
    }
}
