//
//  UserInfoItemView.swift
//  GitHubFollowerSwiftUI
//
//  Created by Manjul Shrestha on 6/6/24.
//

import SwiftUI

struct UserInfoItemView: View {
    
    var title: String
    var systemImage : String
    var count : Int
    
    var body: some View {
        VStack{
            Label(title, systemImage: systemImage)
                .font(.system(size: 18, weight: .semibold))
            Text("\(count)")
                .font(.system(size: 18, weight: .semibold))

        }
    }
}

#Preview {
    UserInfoItemView(title: "Public Repos", systemImage: "folder", count: 30)
}
