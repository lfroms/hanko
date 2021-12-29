//
//  RecordPayload.swift
//  Hanko
//
//  Created by Lukas Romsicki on 2021-12-27.
//

struct RecordPayload {
    let records: [Record]

    init(from payload: String) {
        let lines = payload
            .components(separatedBy: "\n")
            .filter { !$0.isEmpty }

        self.records = lines.map { line in
            Record(data: line)
        }
    }

    var recordSet: NestableRecordSet {
        RecordSet(from: records)
    }
}
