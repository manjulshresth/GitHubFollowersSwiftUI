//
//  GitHubFollowerSwiftUIApp.swift
//  GitHubFollowerSwiftUI
//
//  Created by Manjul Shrestha on 6/4/24.
//

import SwiftUI

@main
struct GitHubFollowerSwiftUIApp: App {
    
    @StateObject private var coreDataManager = CoreDataManager()
    
    var body: some Scene {
        WindowGroup {
            TabView{
                SearchView()
                    .tabItem {
                        Label("Search", systemImage: "magnifyingglass")
                    }
                
                FollowerView()
                    .tabItem {
                        Label("Favorites", systemImage: "heart")
                    }
            }
            .environment(\.managedObjectContext , coreDataManager.container.viewContext)
        }
    }
}
