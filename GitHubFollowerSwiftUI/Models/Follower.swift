//
//  Follower.swift
//  GitHubFollowerSwiftUI
//
//  Created by Manjul Shrestha on 6/4/24.
//

import Foundation


struct Follower : Codable, Identifiable {
    var id = UUID()
    var login: String
    var avatarUrl : String
    
    private enum CodingKeys: String, CodingKey {
        case login = "login"
        case avatarUrl = "avatarUrl"
    }

}
