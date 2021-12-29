//
//  String+FormattedIntoGroupsOfFour.swift
//  Hanko
//
//  Created by Lukas Romsicki on 2021-12-26.
//

extension String {
    var formattedIntoGroupsOfFour: String {
        groupedIntoSubSequences(of: 4).joined(separator: " ")
    }
}
