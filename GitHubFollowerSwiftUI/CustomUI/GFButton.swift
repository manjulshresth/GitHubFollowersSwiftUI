//
//  GFButton.swift
//  GitHubFollowerSwiftUI
//
//  Created by Manjul Shrestha on 6/6/24.
//

import SwiftUI

struct GFButton: View {
    
    var title : String
    var systemImage : String
    var backgroundColor : Color
    
    var function: (() -> Void)?


    var body: some View {
        Button {
            if let function = self.function{
                function()
            }
        } label: {
                Label(title, systemImage : systemImage)
                .frame(maxWidth: .infinity)
                .frame(height: 50)
                .background(backgroundColor)
                .cornerRadius(8)
                .foregroundColor(.white)
        }
        .padding([.leading, .trailing], 10)
    }
}

#Preview {
    GFButton(title: "Get followers", systemImage: "person.3", backgroundColor: .green)
}
