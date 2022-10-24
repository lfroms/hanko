//
//  GPGEngine.swift
//  GPGKit
//
//  Created by Lukas Romsicki on 2022-10-23.
//

import gpgme

public struct GPGEngine {
    public init() {}

    /// Checks the version of the engine, optionally against a required version.
    /// - Parameter requiredVersion: The version requirement.
    public func checkVersion(requiredVersion: String? = nil) {
        gpgme_check_version(requiredVersion)
    }

    /// A collection of information for each engine.
    public var info: [EngineInfo] {
        var info: gpgme_engine_info_t?
        gpgme_get_engine_info(&info)

        var list: [EngineInfo] = []

        while let unwrappedInfo = info {
            list.append(.init(from: unwrappedInfo))
            info = unwrappedInfo.pointee.next
        }

        return list
    }

    /// Sets information for the given protocol
    /// - Parameters:
    ///   - protocol: The protocol to apply the info to.
    ///   - fileName: The file name of the executable implementing the protocol.
    ///   - homeDir: The directory name of the configuration home directory.
    public func setInfo(for protocol: Protocol, fileName: String, homeDir: String) {
        gpgme_set_engine_info(`protocol`.raw, fileName, homeDir)
    }

    /// Returns the value associated with the given property.
    /// - Parameter property: The name of the property.
    /// - Returns: The value assigned to the property.
    public func directoryInfo(for property: String) -> String {
        guard let dirInfo = gpgme_get_dirinfo(property) else {
            return ""
        }

        return String(cString: dirInfo)
    }
}
