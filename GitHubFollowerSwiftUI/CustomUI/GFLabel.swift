//
//  GFLabel.swift
//  GitHubFollowerSwiftUI
//
//  Created by Manjul Shrestha on 6/8/24.
//

import SwiftUI

struct GFLabel: View {
    var text: String
    var systemImage : String
    var color : Color
    var body: some View {
        Label(text, systemImage: systemImage)
            .frame(maxWidth: .infinity)
            .frame(height: 50)
            .background(.purple)
            .cornerRadius(8)
            .foregroundColor(.white)

    }
}

#Preview {
    GFLabel(text: "Text", systemImage: "person", color: .purple)
}
