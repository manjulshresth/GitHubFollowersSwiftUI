//
//  SearchView.swift
//  GitHubFollowerSwiftUI
//
//  Created by Manjul Shrestha on 6/4/24.
//

import SwiftUI

struct SearchView: View {
    @State private var username: String = ""
    
    @State var followers : [Follower] = []
    @State var gotoFollowerVC = false
    @State var showError = false
    @State var alertItem : AlertItem?
    
    var body: some View {
        NavigationStack {
            VStack{
                Spacer().frame(height: 80)
                Image(ImageResource.ghLogo)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 200, height: 200)
                Spacer().frame(height: 48)

                TextField(text: $username) {
                    Text("Enter a username")
                }
                .autocapitalization(.none)
                .autocorrectionDisabled()
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color(UIColor.systemGray4), lineWidth: 2))
                .padding([.leading,.trailing], 40)
                .textFieldStyle(.roundedBorder)
                .frame(height: 50)
                .multilineTextAlignment(.center)
                .font(Font.system(size: 22))
                .submitLabel(.done)

                Spacer()
                
                Button {
                    if username.isEmpty{
                        showError = true
                        alertItem = AlertContext.invalidUsername
                    } else {
                        gotoFollowerVC = true
                    }
                } label: {
                    HStack{
                        Image(systemName: "person.3")
                            .foregroundColor(.white)
                        Text("Get Followers")
                            .foregroundColor(.white)
                            .bold()
                        }
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(Color(UIColor.systemGreen))
                        .cornerRadius(8)
                        .foregroundColor(.white)
                }
                .padding([.leading, .trailing], 40)
                Spacer().frame(height: 50)
            }
            .onAppear {
                username = ""
            }
            .alert(item: $alertItem) { alert in
                Alert(title: alert.title, message: alert.message, dismissButton: alert.dismissButton)
            }
            .navigationDestination(isPresented: $gotoFollowerVC) {
                FollowersListView(username: username)
            }
        }
    }
}

#Preview {
    SearchView()
}
