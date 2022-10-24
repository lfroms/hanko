//
//  KeyDetails.swift
//  Hanko
//
//  Created by Lukas Romsicki on 2021-12-26.
//

import GPGKit
import SwiftUI

struct KeyDetails: View {
    let key: Key
    let didDelete: () -> Void

    @ObservedObject private var viewModel = KeyDetailsViewModel()

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                VStack(spacing: 2) {
                    VStack(spacing: 16) {
                        Circle()
                            .foregroundColor(.gray)
                            .frame(width: 96, height: 96)

                        Text(key.uids.first?.name ?? "")
                            .font(.title)
                            .fontWeight(.bold)
                    }

                    if !(key.uids.first?.name.isEmpty ?? false) {
                        Text(key.uids.first?.email ?? "")
                            .font(.headline)
                            .fontWeight(.medium)
                            .foregroundColor(.secondary)
                    }

                    if !(key.uids.first?.comment.isEmpty ?? false) {
                        Text(key.uids.first?.comment ?? "")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                            .padding(.top, 8)
                    }
                }
                .frame(maxWidth: .infinity)

                VStack(alignment: .leading, spacing: 4) {
                    Text("Information")
                        .font(.headline)
                        .fontWeight(.semibold)
                        .padding(.bottom, 6)

                    ForEach(key.formattedProperties, id: \.name) { property in
                        KeyDetailsRow(name: property.name, value: property.value)

                        if property != key.formattedProperties.last {
                            Divider()
                        }
                    }
                }

                Spacer()
            }
            .textSelection(.enabled)
            .padding()
        }
        .frame(minWidth: 300)
        .toolbar {
            ToolbarItem(placement: .destructiveAction) {
                Button(action: didDelete) {
                    Image(systemName: "trash")
                }
                .help("Delete this key")
            }

            ToolbarItem(placement: .automatic) {
                Button(action: {}) {
                    Image(systemName: "square.and.arrow.up")
                }
                .help("Export this key")
            }
        }
        .navigationTitle(key.uids.first?.name ?? "")
    }

    struct Placeholder: View {
        var body: some View {
            Text("No Selection")
                .font(.title2)
                .foregroundColor(.secondary)
                .frame(minWidth: 300, maxWidth: 300)
                .toolbar {
                    ToolbarItem(placement: .destructiveAction) {
                        Button(action: {}) {
                            Image(systemName: "trash")
                        }
                        .disabled(true)
                    }

                    ToolbarItem(placement: .automatic) {
                        Button(action: {}) {
                            Image(systemName: "square.and.arrow.up")
                        }
                        .disabled(true)
                    }
                }
        }
    }
}
