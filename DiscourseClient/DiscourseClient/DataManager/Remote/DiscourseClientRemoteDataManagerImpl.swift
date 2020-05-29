//
//  DiscourseClientRemoteDataManagerImpl.swift
//  DiscourseClient
//
//  Created by Roberto Garrido on 01/02/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import Foundation

/// Implementación por defecto del protocolo remoto, en este caso usando SessionAPI
class DiscourseClientRemoteDataManagerImpl: DiscourseClientRemoteDataManager {
    
    let session: SessionAPI

    init(session: SessionAPI) {
        self.session = session
    }

    func fetchAllTopics(completion: @escaping (Result<LatestTopicsResponse?, Error>) -> ()) {
        let request = LatestTopicsRequest()
        session.send(request: request) { result in
            completion(result)
        }
    }

    func fetchTopic(id: Int, completion: @escaping (Result<SingleTopicResponse?, Error>) -> ()) {
        let request = SingleTopicRequest(id: id)
        session.send(request: request) { result in
            completion(result)
        }
    }

    func addTopic(title: String, raw: String, createdAt: String, completion: @escaping (Result<AddNewTopicResponse?, Error>) -> ()) {
        let request = CreateTopicRequest(title: title, raw: raw, createdAt: createdAt)
        session.send(request: request) { result in
            completion(result)
        }
    }
    
    func deleteTopic(id: Int, completion: @escaping (Result<RemoveTopicResponse?, Error>) -> ()) {
        let request = RemoveTopicRequest(id: id)
        session.send(request: request) { (result) in
            completion(result)
        }
    }
    
    func fetchAllCategories(completion: @escaping (Result<CategoriesResponse?, Error>) -> ()) {
        let request = CategoriesRequest()
        session.send(request: request) { (result) in
            completion(result)
        }
    }
    
    func fetchAllUsers(completion: @escaping (Result<UsersResponse?, Error>) -> ()) {
        let request = UserRequest()
        session.send(request: request) { (result) in
            completion(result)
        }
    }
    
    func fetchUser(userName: String, completion: @escaping (Result<SingleUserResponse?, Error>) -> ()) {
        let request = SingleUserRequest(userName: userName)
        session.send(request: request) { (result) in
            completion(result)
        }
    }
    
    func editUserName(userName: String, name: String, completion: @escaping (Result<EditSingleUserResponse?, Error>) -> ()) {
        let request = EditSingleUserRequest(userName: userName, name: name)
        session.send(request: request) { (result) in
            completion(result)
        }
    }
    
}
