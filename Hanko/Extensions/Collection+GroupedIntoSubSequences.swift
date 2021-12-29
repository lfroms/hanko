//
//  Collection+GroupedIntoSubSequences.swift
//  Hanko
//
//  Created by Lukas Romsicki on 2021-12-26.
//

extension Collection {
    func unfoldSubSequences(limitedTo maxLength: Int) -> UnfoldSequence<SubSequence, Index> {
        sequence(state: startIndex) { start in
            guard start < self.endIndex else { return nil }
            let end = self.index(start, offsetBy: maxLength, limitedBy: self.endIndex) ?? self.endIndex
            defer { start = end }
            return self[start ..< end]
        }
    }

    func every(n: Int) -> UnfoldSequence<Element, Index> {
        sequence(state: startIndex) { index in
            guard index < endIndex else { return nil }
            defer { index = self.index(index, offsetBy: n, limitedBy: endIndex) ?? endIndex }
            return self[index]
        }
    }

    func groupedIntoSubSequences(of size: Int) -> [SubSequence] {
        return .init(unfoldSubSequences(limitedTo: 4))
    }
}
