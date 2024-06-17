//
//  Alert.swift
//  FoodSwiftUI
//
//  Created by Manjul Shrestha on 6/6/24.
//

import SwiftUI

struct AlertItem : Identifiable{
    let id = UUID()
    let title : Text
    let message : Text
    let dismissButton : Alert.Button
}



struct AlertContext{
    static let invalidURL = AlertItem(title: Text("Server Error"),
                                      message: Text("There was issue connecting server."),
                                      dismissButton: .default(Text("OK")))
    static let invalidResponse = AlertItem(title: Text("Server Error"),
                                           message: Text("Invalid response from server"),
                                           dismissButton: .default(Text("OK")))
    static let invalidData = AlertItem(title: Text("Server Error"),
                                       message: Text("Data received from server is not valid"),
                                       dismissButton: .default(Text("OK")))
    static let unableToComplete = AlertItem(title: Text("Server Error"),
                                            message: Text("Unable to complete your request. Check network connection"),
                                            dismissButton: .default(Text("OK")))
    static let invalidUsername = AlertItem(title: Text("Invalid username"),
                                        message: Text("Please enter a username"),
                                        dismissButton: .default(Text("OK")))
    static let emptyFollowers = AlertItem(title: Text("No followers"),
                                        message: Text("This user has no followers. Please go follow them!"),
                                        dismissButton: .default(Text("OK")))
    static let invalidForm = AlertItem(title: Text("Invalid form"), 
                                       message: Text("Please complete your form"),
                                       dismissButton: .default(Text("OK")))
    static let userSaveSuccess = AlertItem(title: Text("Success"),
                                       message: Text("This user has been added to favorites"),
                                       dismissButton: .default(Text("OK")))
    static let userSaveFailure = AlertItem(title: Text("Error"),
                                       message: Text("There was an error saving or retrieving the user"),
                                       dismissButton: .default(Text("OK")))
    static let userAlreadyFavorite = AlertItem(title: Text("Error"),
                                       message: Text("This user is already added as favorite"),
                                       dismissButton: .default(Text("OK")))

    
}

