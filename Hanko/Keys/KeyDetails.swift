//
//  KeyDetails.swift
//  Hanko
//
//  Created by Lukas Romsicki on 2021-12-26.
//

import GPGKit
import SwiftUI

struct KeyDetails: View {
    @EnvironmentObject var keyStore: KeyStore

    let key: Key

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                if let primaryUid = key.uids.first {
                    VStack(spacing: 2) {
                        VStack(spacing: 16) {
                            ProfileView(name: primaryUid.name, size: .large)

                            Text(primaryUid.name)
                                .font(.title)
                                .fontWeight(.bold)
                        }

                        Text(primaryUid.email)
                            .font(.headline)
                            .fontWeight(.medium)
                            .foregroundColor(.secondary)

                        if !primaryUid.comment.isEmpty {
                            Text(primaryUid.comment)
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                                .padding(.top, 8)
                        }
                    }
                    .frame(maxWidth: .infinity)
                }

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
            }
            .textSelection(.enabled)
            .padding()

            Form {
                Section {
                    Picker(selection: .constant("Ultimate")) {
                        Text("Ultimate")
                            .tag("Ultimate")
                    } label: {
                        Text("Owner Trust")
                    }

                    Toggle("Enabled", isOn: .constant(true))
                }

                Section {
                    ForEach(Array(key.uids.dropFirst()), id: \.id) { uid in
                        NavigationLink {
                            Text("Hello")
                        } label: {
                            HStack {
                                RoundedRectangle(cornerRadius: 5)
                                    .foregroundStyle(.linearGradient(colors: [.init(white: 0.75), .init(white: 0.5)], startPoint: .top, endPoint: .bottom))
                                    .frame(width: 20, height: 20)
                                    .overlay {
                                        Image(systemName: "person.crop.circle")
                                    }

                                Text(uid.comment)
                            }
                        }
                    }
                } header: {
                    Text("Identities")
                    Text("An identity associates a name and email address with the key.")
                } footer: {
                    Button("Add Identity…") {}
                }

                Section {
                    ForEach(key.subkeys, id: \.fingerprint) { subkey in
                        NavigationLink {
                            Text("Hello")
                                .toolbar {
                                    ToolbarItem {
                                        NavigationLink {
                                            Self(key: key)
                                        } label: {
                                            Image(systemName: "chevron.left")
                                        }
                                    }
                                }
                        } label: {
                            HStack {
                                RoundedRectangle(cornerRadius: 5)
                                    .foregroundStyle(.linearGradient(colors: [.blue, .blue], startPoint: .top, endPoint: .bottom))
                                    .frame(width: 20, height: 20)
                                    .overlay {
                                        Image(systemName: "key.fill")
                                    }

                                Text("\(subkey.algorithm.description) (\(subkey.length) bit)")
                            }
                        }
                    }
                } header: {
                    Text("Subkeys")
                    Text("Subkeys are derived and can be revoked independently from the primary key, making them more convenient to distribute widely.")
                } footer: {
                    Button("Add Subkey…") {}
                }
            }
            .formStyle(.grouped)
            .padding(-6)
        }
        .toolbar {
            ToolbarItem {
                Button {
                    keyStore.delete(key: key)
                } label: {
                    Image(systemName: "trash")
                }
                .help("Delete this key")
            }

            ToolbarItem {
                Button(action: {}) {
                    Image(systemName: "square.and.arrow.up")
                }
                .help("Export this key")
            }
        }
        .frame(minWidth: 300)
    }
}

extension KeyDetails {
    struct Placeholder: View {
        var body: some View {
            Text("No Selection")
                .font(.title2)
                .foregroundColor(.secondary)
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
                .frame(minWidth: 300)
        }
    }
}
