//
//  PrimaryKey.swift
//  Hanko
//
//  Created by Lukas Romsicki on 2021-12-28.
//

class PrimaryKey: Key {
    let ownerTrust: Validity
    let subkeys: [Key]

    override init(from recordSet: RecordSet) throws {
        self.ownerTrust = Validity(rawValue: recordSet.primaryRecord.properties[8]) ?? .unknown
        self.subkeys = try recordSet.recordSets(of: [.subkey, .secretSubkey]).map { try Key(from: $0) }

        try super.init(from: recordSet)
    }
}
