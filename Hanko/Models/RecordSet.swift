//
//  RecordSet.swift
//  Hanko
//
//  Created by Lukas Romsicki on 2021-12-27.
//

struct RecordSet: NestableRecordSet {
    private let records: [Record]

    init(from records: [Record]) {
        self.records = records
    }

    func recordSets(of types: [RecordType]) -> [RecordSet] {
        var groups: [[Record]] = []
        var currentGroup: [Record] = []

        records.forEach { record in
            if types.contains(record.type) {
                if !currentGroup.isEmpty {
                    groups.append(currentGroup)
                    currentGroup.removeAll()
                }

                currentGroup.append(record)
            } else {
                if !currentGroup.isEmpty {
                    currentGroup.append(record)
                }
            }
        }

        groups.append(currentGroup)

        return groups.map { RecordSet(from: $0) }
    }

    var primaryRecord: Record {
        // For a record set to exist, it must have been instantiated with at least
        // one record.
        records.first!
    }

    var subRecords: ArraySlice<Record> {
        records.dropFirst()
    }
}
