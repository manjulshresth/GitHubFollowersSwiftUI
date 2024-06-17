//
//  CoreDataManager.swift
//  GitHubFollowerSwiftUI
//
//  Created by Manjul Shrestha on 6/9/24.
//

import CoreData
import Foundation

class CoreDataManager : ObservableObject{
    let container = NSPersistentContainer(name: "FavFollower")
    
    init(){
        container.loadPersistentStores { description, error in
            if let error {
                print("Core data failed to load : \(error.localizedDescription)")
            }
        }
    }
    
    
}
