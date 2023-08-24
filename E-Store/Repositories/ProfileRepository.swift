//
//  ProfileRepository.swift
//  E-Store
//
//  Created by Laptop MCO on 16/08/23.
//

import UIKit
import CoreData

class ProfileRepository {
//    static let shared: ProfileRepository = ProfileRepository()
    
    private let apiService: ApiService
    init(apiService: ApiService) {
        self.apiService = apiService
    }
    
    var context: NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    var currentProfile: Profile? {
        get{
            let request = ProfileData.fetchRequest()
            if let profileData = try? context.fetch(request).first, let data = profileData.data
            {
                let profile = try? JSONDecoder().decode(Profile.self, from: data)
                return profile
            }
            return nil
        }
        
        set {
            let request = ProfileData.fetchRequest()
            if let profileData = try? context.fetch(request).first {
                context.delete(profileData)
            }
            
            if let profile = newValue{
                let profileData = ProfileData(context: context)
                profileData.data = try? JSONEncoder().encode(profile)
            }
            try? context.save()
        }
    }
    
    func loadProfile(forced: Bool = false, completion: @escaping (Profile?) -> Void){
        if !forced, let profile = currentProfile {
            completion(profile)
        }else {
            apiService.loadProfile { (profile) in
                self.currentProfile = profile
                completion(profile)
            }
        }
    }
}
