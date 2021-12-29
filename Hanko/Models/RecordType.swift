//
//  RecordType.swift
//  Hanko
//
//  Created by Lukas Romsicki on 2021-12-26.
//

enum RecordType: String {
    case publicKey = "pub"
    case certificate = "crt"
    case certificateAndPrivateKey = "crs"
    case subkey = "sub"
    case secretKey = "sec"
    case secretSubkey = "ssb"
    case userId = "uid"
    case userAttribute = "uat"
    case signature = "sig"
    case revocationSignature = "rev"
    case fingerprint = "fpr"
    case publicKeyData = "pkd"
    case keygrip = "grp"
    case revocationKey = "rvk"
    case trustDatabaseInformation = "tru"
    case signatureSubpacket = "spk"
    case configurationData = "cfg"
    case unknown
}
