//
//  UserInfoView.swift
//  GitHubFollowerSwiftUI
//
//  Created by Manjul Shrestha on 6/6/24.
//

import SwiftUI
import SafariServices

struct UserInfoView: View {
    
    var follower : Follower
    @Binding var showFollowerDetail : Bool
    @Binding var username: String
    
    @StateObject var viewModel = UserInfoViewModel()
    @ObservedObject var viewModel2: FollowerListViewModel
    
    @Environment(\.managedObjectContext) var coreDataContext
    
    @FetchRequest(sortDescriptors: []) var savedFollowers: FetchedResults <FavFollower>

    
    static let taskDateFormat: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter
    }()
    
    
    var body: some View {
        ZStack {
            NavigationStack{
                VStack(alignment: .leading){
                    AddDissmissView (followerButtonAction: {
                        if savedFollowers.contains(where: { $0.login == viewModel.user?.login }){
                            viewModel.alertItem = AlertContext.userAlreadyFavorite
                        }
                        else{
                            let favFollower = FavFollower(context: coreDataContext)
                            favFollower.login = viewModel.user?.login
                            favFollower.avatarURL = viewModel.user?.avatarUrl

                            do {
                                try coreDataContext.save()
                                viewModel.alertItem = AlertContext.userSaveSuccess
                            }
                            catch {
                                viewModel.alertItem = AlertContext.userSaveFailure
                            }
                        }
                    }, dismissButtonAction: {
                        showFollowerDetail = false
                    })
                    UserInfoTopView(avatarUrl: viewModel.user?.avatarUrl ?? "", loginName: viewModel.user?.login ?? "", name: viewModel.user?.name ?? "", location: viewModel.user?.location)
                        .padding()
                    if let bio = viewModel.user?.bio{
                        Text(bio)
                            .multilineTextAlignment(.leading)
                            .padding()
                    }
                    VStack(alignment: .leading, spacing: 15) {
                        GroupBox(){
                            VStack{
                                HStack {
                                    UserInfoItemView(title: "Public Repos", systemImage: "folder", count: viewModel.user?.publicRepos ?? 0)
                                    Spacer()
                                    UserInfoItemView(title: "Public Gists", systemImage: "text.alignleft", count: viewModel.user?.publicGists ?? 0)
                                }
                                
                                if viewModel.user != nil {
                                    Link(destination: URL(string: viewModel.user?.htmlUrl ?? "")!, label: {
                                        GFLabel(text: "GitHub Profile", systemImage: "person", color: .purple)
                                    })
                                }
                            }
                        }
                        GroupBox(){
                            VStack{
                                HStack{
                                    UserInfoItemView(title: "Followers", systemImage: "heart", count: viewModel.user?.followers ?? 0)
                                    Spacer()
                                    UserInfoItemView(title: "Following", systemImage: "person.2", count: viewModel.user?.followers ?? 0)
                                }
                                
                                GFButton(title: "Get Followers", systemImage: "person.3", backgroundColor: .green) {
                                    showFollowerDetail = false
                                    if let selectedFollower = viewModel2.selectedFollower{
                                        username = selectedFollower.login
                                    }
                                }
                                
                            }
                        }
                    }
                    .padding()
                }
                Text("GitHub user since: \(viewModel.user?.createdAt ?? Date(), formatter: Self.taskDateFormat)")
                    .multilineTextAlignment(/*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/)
                Spacer()
            }
            if(viewModel.isLoadingUser){
                ProgressView()
                    .progressViewStyle(.circular)
            }
        }
        .task {
            viewModel.getUserInfo(username: follower.login)
        }
        .alert(item: $viewModel.alertItem) { alert in
            Alert(title: alert.title, message: alert.message, dismissButton: alert.dismissButton)
        }

        
    }
    
    func handleURL(_ url: URL) -> OpenURLAction.Result {
        print("Handle \(url) somehow")
        return .handled
    }
}

#Preview {
    UserInfoView(follower: Follower(login: "manjulshresth", avatarUrl: ""), showFollowerDetail: .constant(true), username: .constant("manjulshresth"), viewModel2: FollowerListViewModel())
    
    
}


struct AddDissmissView: View{
    
    var followerButtonAction : (() -> Void)?
    var dismissButtonAction : (() -> Void)?
    
    var body: some View {
        HStack{
            Button(action: {
                if let followerButtonAction{
                    followerButtonAction()
                }
            }, label: {
                Image(systemName: "plus")
                    .resizable()
                    .frame(width: 28, height: 28)
                    .tint(.green)
            })
            .padding()
            Spacer()
            
            Button(action: {
                if let dismissButtonAction{
                    dismissButtonAction()
                }
            }, label: {
                Text("Done")
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundStyle(.green)
            })
            .padding()
        }
        
    }
}

struct UserInfoTopView : View{
    
    var avatarUrl : String
    var loginName: String
    var name: String
    var location : String?
    
    var body: some View{
        GroupBox(){
            HStack {
                AsyncImage(url: URL(string: avatarUrl)) { image in
                    image
                        .resizable()
                } placeholder: {
                    Image(.ghLogo)
                        .resizable()
                }
                .aspectRatio(contentMode: .fit)
                .frame(width: 100, height: 100)
                .cornerRadius(10)
                
                
                VStack(alignment: .leading, spacing: 5){
                    Text(loginName)
                        .font(.system(size: 20, weight: .bold))
                    Text(name)
                    Label(location ?? "",
                          systemImage : ((location) == nil) ? "" : "mappin.and.ellipse")
                    
                }
                .padding()
                Spacer()
            }
        }
    }
}
