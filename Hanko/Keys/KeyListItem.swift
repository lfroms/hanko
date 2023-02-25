//
//  KeyListItem.swift
//  Hanko
//
//  Created by Lukas Romsicki on 2021-12-26.
//

import GPGKit
import SwiftUI

struct KeyListItem: View {
    let key: Key

    var body: some View {
        HStack(alignment: .center) {
            if let name = key.uids.first?.name {
                ProfileView(name: name, size: .small)
            }

            VStack(alignment: .leading, spacing: 4) {
                HStack(alignment: .firstTextBaseline, spacing: 6) {
                    Text(key.uids.first?.name ?? "")
                        .font(.headline)

                    Text(key.uids.first?.email ?? "")
                        .font(.headline)
                        .fontWeight(.medium)
                        .foregroundColor(.secondary)
                }

                Text(key.fingerprint.formattedIntoGroupsOfFour)
                    .font(.monospaced(.caption)())
                    .foregroundColor(.secondary)
            }

            Spacer()

            if key.isSecret {
                Image(systemName: "lock.fill")
                    .foregroundColor(.blue)
                    .help("Secret Key")
            }

            // TODO: Confirm this logic.
            if key.isInvalid || key.isExpired || key.isRevoked {
                Image(systemName: "xmark.seal.fill")
                    .foregroundColor(.red)
                    .help("Invalid")

            } else {
                Image(systemName: "checkmark.seal.fill")
                    .foregroundColor(.green)
                    .help("Valid")
            }
        }
        .padding(.vertical, 6)
        .padding(.horizontal, 4)
    }
}
