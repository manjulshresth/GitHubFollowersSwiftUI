//
//  FollowerListViewModel.swift
//  GitHubFollowerSwiftUI
//
//  Created by Manjul Shrestha on 6/8/24.
//

import SwiftUI

@MainActor class FollowerListViewModel: ObservableObject{
    @Published var followers : [Follower] = []
    @Published var showFollowerDetail : Bool = false
    @Published var needLoadMore : Bool = true
    @Published var isLoading : Bool = true
    
    @Published var alertItem : AlertItem?
    @Published var showError = false

    
    let columns : [GridItem] = [GridItem(.flexible()),GridItem(.flexible()),GridItem(.flexible())]


    @Published var selectedFollower : Follower? {
        didSet {
            showFollowerDetail = true
        }
    }
    
    var page : Int = 1
    
    func resetForNewFollowers(){
        followers = []
        page = 1
        needLoadMore = true
    }

    func getFollowers(username : String){
        isLoading = true
        Task{
            do{
                print(username)
//                let resultFollowers = try await NetworkManager.shared.getFollowers(for: username, page: page)
                let resultFollowers = try await NetworkManager.shared.getDataForView(forEndPoint: .followers(usernme: username, page: page), responseType: [Follower].self)
                if (resultFollowers.isEmpty){
                    needLoadMore = false
                    showError = true
                    page = 1
                    isLoading = false
                    alertItem = AlertContext.emptyFollowers

                }
                else{
                    if (resultFollowers.count < 100){
                        needLoadMore = false
                        showError = true
                    }
                    print(page)
                    page = page + 1
                    print(resultFollowers.count)
                    followers.append(contentsOf: resultFollowers)
                    print(followers.count)
                    isLoading = false

                }
            } catch {
                showError = true
                needLoadMore = false
                isLoading = false
                if let error = error as? AppError{
                    switch error{
                    case .invalidURL:
                        alertItem = AlertContext.invalidURL
                    case .invalidData:
                        alertItem = AlertContext.invalidData

                    case .invalidResponse:
                        alertItem = AlertContext.invalidResponse

                    case .invalidUsername:
                        alertItem = AlertContext.invalidUsername
                    case .unableToComplete:
                        alertItem = AlertContext.unableToComplete
                    }
                }
            }
        }
    }
    

}
