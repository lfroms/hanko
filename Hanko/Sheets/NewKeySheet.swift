//
//  NewKeySheet.swift
//  Hanko
//
//  Created by Lukas Romsicki on 2021-12-28.
//

import SwiftUI

struct NewKeySheet: View {
    @Binding var sheetVisible: Bool

    @ObservedObject private var viewModel = NewKeySheetViewModel()

    var body: some View {
        VStack {
            Form {
                TextField("Full Name", text: $viewModel.name)
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
                    viewModel.createKey()
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
