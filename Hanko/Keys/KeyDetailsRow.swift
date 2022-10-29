//
//  KeyDetailsRow.swift
//  Hanko
//
//  Created by Lukas Romsicki on 2021-12-28.
//

import SwiftUI

struct KeyDetailsRow: View {
    let name: String
    let value: String

    var body: some View {
        HStack(alignment: .firstTextBaseline) {
            Text(name)
                .font(.subheadline)
                .fontWeight(.semibold)
                .foregroundColor(.secondary)

            Spacer()

            Text(value)
                .font(.subheadline)
                .fontWeight(.medium)
        }
    }
}
