//
//  KeyListItem.swift
//  Hanko
//
//  Created by Lukas Romsicki on 2021-12-26.
//

import SwiftUI
import GPGKit

struct KeyListItem: View {
    let key: Key

    var body: some View {
        HStack(alignment: .center) {
            Circle()
                .foregroundColor(.gray)
                .frame(width: 36, height: 36)

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

            Image(systemName: "globe.americas.fill")
                .foregroundColor(.blue)
                .help("Public Key")

            // TODO: Confirm this logic.
            if [.ultimate, .full, .marginal].contains(key.ownerTrust) {
                Image(systemName: "checkmark.seal.fill")
                    .foregroundColor(.green)
                    .help("Valid")
            } else {
                Image(systemName: "xmark.seal.fill")
                    .foregroundColor(.red)
                    .help("Invalid")
            }
        }
        .padding(.vertical, 6)
        .padding(.horizontal, 4)
    }
}
