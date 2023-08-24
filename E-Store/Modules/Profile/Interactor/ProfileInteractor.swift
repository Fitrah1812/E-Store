//
//  ProfileInteractor.swift
//  E-Store
//
//  Created by Laptop MCO on 14/08/23.
//

import Foundation

protocol ProfileInteractor {
    func loadProfile(completion: @escaping (Profile?) -> Void)
}

final class DefaultProfileInteractor {
    private let profileRepository: ProfileRepository
    
    init(profileRepository: ProfileRepository) {
        self.profileRepository = profileRepository
    }
}

extension DefaultProfileInteractor: ProfileInteractor {
    func loadProfile(completion: @escaping (Profile?) -> Void) {
        profileRepository.loadProfile(forced: true, completion: completion)
    }
}
