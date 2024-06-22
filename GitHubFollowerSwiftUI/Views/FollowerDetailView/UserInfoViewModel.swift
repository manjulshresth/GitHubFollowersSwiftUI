//
//  UserInfoViewModel.swift
//  GitHubFollowerSwiftUI
//
//  Created by Manjul Shrestha on 6/8/24.
//

import SwiftUI

@MainActor class UserInfoViewModel: ObservableObject{
    
    @Published var user : User?
    @Published var isLoadingUser : Bool = true
    
    @Published var alertItem : AlertItem?

    func getUserInfo(username : String){
        isLoadingUser = true
        Task{
            do{
//              user = try await NetworkManager.shared.getUserInfo(for: username)
                user = try await NetworkManager.shared.getDataForView(forEndPoint: .userInfo(username: username), responseType: User.self)
                isLoadingUser = false
            } catch {
                print("Some error")
                isLoadingUser = false
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

