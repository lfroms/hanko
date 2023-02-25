//
//  NewKeySheet.swift
//  Hanko
//
//  Created by Lukas Romsicki on 2021-12-28.
//

import GPGKit
import SwiftUI

struct NewKeySheet: View {
    @EnvironmentObject var keyStore: KeyStore

    @Binding var sheetVisible: Bool

    @State var name: String = ""
    @State var email: String = ""
    @State var comment: String = ""
    @State var algorithm: KeyAlgorithm = .ecc
    @State var curve: Curve = .ed25519
    @State var expirationDate: Date = .now
    @State var keyLength: KeyLength = .medium
    @State var keyExpires: Bool = false

    let algorithms: [KeyAlgorithm] = [.rsa, .ecc]

    var body: some View {
        VStack(alignment: .trailing, spacing: 0) {
            Form {
                Section("Create New Key") {
                    TextField("Full Name", text: $name, prompt: Text("Full Name"))
                    TextField("Email", text: $email, prompt: Text("Email"))
                    TextField("Comment", text: $comment, prompt: Text("Comment"))
                }
                
                Section {
                    Picker(selection: $algorithm) {
                        ForEach(algorithms, id: \.self) { algorithm in
                            Text(String(describing: algorithm))
                        }
                    } label: {
                        Text("Algorithm")
                        Text("For better security, choose an algorithm that uses elliptic-curve cryptography (ECC).")
                    }
                    
                    if algorithm == .ecc {
                        Picker("Curve", selection: $curve) {
                            ForEach(Curve.allCases, id: \.self) { curve in
                                Text(curve.description)
                            }
                        }
                    }
                }
                
                Section {
                    Picker(selection: $keyLength) {
                        ForEach(KeyLength.allCases, id: \.self) { length in
                            Text("\(length.rawValue) bits")
                        }
                    } label: {
                        Text("Key Length")
                        Text("A longer key is more secure, but is typically slower to process.")
                    }
                }
                
                Section {
                    Toggle(isOn: $keyExpires) {
                        Text("Key Expires")
                        Text("When enabled, the key will expire on the selected date.")
                    }
                    
                    if keyExpires {
                        DatePicker("Expiration Date", selection: $expirationDate)
                    }
                }
            }
            .fixedSize()
            .formStyle(.grouped)
            
            Divider()
            
            HStack {
                Button {
                    sheetVisible = false
                } label: {
                    Text("Cancel")
                        .padding(.horizontal, 10)
                }
                .keyboardShortcut(.cancelAction)
                    
                Button {
                    didPerformPrimaryAction()
                } label: {
                    Text("Create")
                        .padding(.horizontal, 10)
                }
                .keyboardShortcut(.defaultAction)
            }
            .padding(20)
        }
    }
    
    private func didPerformPrimaryAction() {
        let configuration = KeyGenerationConfiguration(
            keyType: algorithm,
            keyLength: keyLength,
            keyUsage: [],
            curve: algorithm == .ecc ? curve : nil,
            fullName: name,
            email: email,
            comment: comment,
            expirationDate: keyExpires ? expirationDate : nil
        )
            
        keyStore.create(configuration: configuration)
        sheetVisible = false
    }
}
