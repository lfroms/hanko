//
//  FormItem.swift
//  Hanko
//
//  Created by Lukas Romsicki on 2022-10-30.
//

import SwiftUI

struct FormItem: View {
    let title: LocalizedStringKey

    var body: some View {
        HStack {
            RoundedRectangle(cornerRadius: 5)
                .foregroundStyle(.linearGradient(colors: [.init(white: 0.75), .init(white: 0.5)], startPoint: .top, endPoint: .bottom))
                .frame(width: 20, height: 20)
                .overlay {
                    Image(systemName: "person.crop.circle")
                }

            Text(title)
        }
    }
}
