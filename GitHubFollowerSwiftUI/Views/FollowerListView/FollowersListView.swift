//
//  FollowersListView.swift
//  GitHubFollowerSwiftUI
//
//  Created by Manjul Shrestha on 6/4/24.
//

import SwiftUI

struct FollowersListView: View {
    @State var username : String
    @State var searchText : String = ""
    @State var showAlert: Bool = false

    @StateObject var viewModel = FollowerListViewModel()
    
    
    var body: some View {
        ZStack {
            NavigationStack{
                ScrollView{
                    LazyVGrid(columns: viewModel.columns, content: {
                        ForEach(viewModel.followers.filter { searchText.isEmpty || $0.login.localizedCaseInsensitiveContains(searchText) }) { follower in
                            GridCells(follower: follower)
                            .onTapGesture {
                                viewModel.selectedFollower = follower
                            }
                        }
                        if(viewModel.needLoadMore && searchText == ""){
                            Color.clear
                                .frame(maxWidth: .infinity, maxHeight: 10)
                                .onAppear {
                                        viewModel.getFollowers(username: username)
                                }
                        }
                    })
                    .searchable(text: $searchText, prompt: "Search for username")
                    
                }
                .navigationTitle(username)
                .sheet(isPresented: $viewModel.showFollowerDetail, onDismiss: {
                    if username == viewModel.selectedFollower?.login{
                        viewModel.resetForNewFollowers()
                    }
                }) {
                    if let selectedFollower = viewModel.selectedFollower {
                        UserInfoView(follower: selectedFollower, showFollowerDetail: $viewModel.showFollowerDetail, username: $username, viewModel2: viewModel)
                    }
                }
                .alert(item: $viewModel.alertItem) { alert in
                    Alert(title: alert.title, message: alert.message, dismissButton: alert.dismissButton)
                }
                Spacer()

            }
            if(viewModel.isLoading){
                ProgressView()
            }
        }
    }
}

#Preview {
    FollowersListView(username: "sallen0400")
}

