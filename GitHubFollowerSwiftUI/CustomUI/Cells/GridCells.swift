//
//  GridCells.swift
//  GitHubFollowerSwiftUI
//
//  Created by Manjul Shrestha on 6/6/24.
//

import SwiftUI

struct GridCells: View {
    var follower : Follower
    var body: some View {
        VStack{
            AsyncImage(url: URL(string: follower.avatarUrl)) { image in
                image
                    .resizable()
                
            } placeholder: {
                Image(.ghLogo)
                    .resizable()
            }
            .aspectRatio(contentMode: .fit)
            .frame(width: 100, height: 100)
            .cornerRadius(10)
            
            Text(follower.login)
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundStyle(Color(.label))
                .scaledToFit()
                .minimumScaleFactor(0.6)
        }
        .padding()
        
    }
}

#Preview {
    GridCells(follower: Follower(login: "Username goes here", avatarUrl: "asdf"))
}
