//
//  FollowerView.swift
//  GitHubFollowerSwiftUI
//
//  Created by Manjul Shrestha on 6/7/24.
//

import SwiftUI

struct FollowerView: View {
    @FetchRequest(sortDescriptors: []) var followers: FetchedResults <FavFollower>
    
    @Environment(\.managedObjectContext) var coreDataContext
    
    
    var body: some View {
        NavigationStack {
            List() {
                ForEach(followers) { follower in
                    HStack{
                        AsyncImage(url: URL(string: follower.avatarURL ?? "")) { image in
                            image
                                .resizable()
                            
                        } placeholder: {
                            Image(.ghLogo)
                                .resizable()
                        }
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 60, height: 60)
                        .cornerRadius(10)
                        
                        Text(follower.login ?? "")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .foregroundStyle(Color(.label))
                            .scaledToFit()
                            .minimumScaleFactor(0.6)
                    }
                }
                .onDelete(perform: { indexSet in
                    deleteItems(offsets: indexSet)
                })
            }
            .navigationTitle("Favorites")
            .listStyle(.plain)
        }
    }
    
    private func deleteItems(offsets: IndexSet) {
        offsets.map { followers[$0] }.forEach(coreDataContext.delete)
        // Save the context after deletion
        do {
            try coreDataContext.save()
        } catch {
            // Handle the error
            let error = error as NSError
            fatalError("Unresolved error \(error), \(error.userInfo)")
        }
    }
    
}

#Preview {
    FollowerView()
}
