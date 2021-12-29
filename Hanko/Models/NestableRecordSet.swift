//
//  NestableRecordSet.swift
//  Hanko
//
//  Created by Lukas Romsicki on 2021-12-27.
//

protocol NestableRecordSet {
    func recordSets(of types: [RecordType]) -> [RecordSet]
}
