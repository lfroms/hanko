//
//  NewKeyOperation.swift
//  Hanko
//
//  Created by Lukas Romsicki on 2021-12-28.
//

struct NewKeyOperation {
    let keyType: String
    let subkeyType: String
    let name: String
    let comment: String
    let email: String
    let expirationDate: String
    
    let askPassphrase: Bool
    
    var stringRepresentation: String {
        var output: [String] = []
        
        output.append("Key-Type: \(keyType)")
        output.append("Subkey-type: \(subkeyType)")
        output.append("Name-Real: \(name)")
        output.append("Name-Email: \(email)")
        output.append("Name-Comment: \(comment)")
        output.append("Expire-Date: \(expirationDate)")
        
        if askPassphrase {
            output.append("%ask-passphrase")
        }
        
        output.append("%commit")
        
        return output.joined(separator: "\n")
    }
}
