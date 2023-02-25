//
//  ProfileView.swift
//  Hanko
//
//  Created by Lukas Romsicki on 2022-10-30.
//

import SwiftUI

struct ProfileView: View {
    @Environment(\.colorScheme) var colorScheme
    
    let name: String
    let size: Size

    var body: some View {
        Circle()
            .foregroundStyle(.linearGradient(colors: gradientColors, startPoint: .top, endPoint: .bottom))
            .frame(width: size.rawValue, height: size.rawValue)
            .overlay {
                Text(initials)
                    .font(font)
                    .fontDesign(.rounded)
                    .fontWeight(.medium)
                    .foregroundColor(.white)
                    .textSelection(.disabled)
            }
    }
    
    var initials: String {
        let names = name.split(separator: " ")
        
        guard
            let firstInitial = names.first?.first?.uppercased(),
            let lastInitial = names.last?.first?.uppercased()
        else {
            return ""
        }
        
        if names.count == 1 {
            return String(firstInitial)
        }
        
        return "\(firstInitial)\(lastInitial)"
    }
    
    var gradientColors: [Color] {
        if colorScheme == .dark {
            return [Color(white: 0.42), Color(white: 0.3)]
        }
        
        return [Color(white: 0.76), Color(white: 0.6)]
    }
    
    var font: Font {
        switch size {
            case .small:
                return .title3
            case .large:
                return .system(size: 42)
        }
    }
    
    enum Size: CGFloat {
        case small = 36
        case large = 96
    }
}
