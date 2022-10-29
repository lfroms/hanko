//
//  NewKeySheet.swift
//  Hanko
//
//  Created by Lukas Romsicki on 2021-12-28.
//

import SwiftUI

struct NewKeySheet: View {
    @EnvironmentObject var keyStore: KeyStore

    @Binding var sheetVisible: Bool

    @State var name: String = ""

    var body: some View {
        VStack {
            Form {
                TextField("Full Name", text: $name)
            }

            HStack {
                Button {
                    sheetVisible = false
                } label: {
                    Text("Cancel")
                        .padding(.horizontal, 10)
                }
                .keyboardShortcut(.cancelAction)

                Button {
                    keyStore.create(name: name)
                    sheetVisible = false
                } label: {
                    Text("Create")
                        .padding(.horizontal, 10)
                }
                .keyboardShortcut(.defaultAction)
            }
        }
        .padding()
    }
}
