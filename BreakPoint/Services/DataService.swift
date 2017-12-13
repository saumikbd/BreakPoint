//
//  DataService.swift
//  BreakPoint
//
//  Created by Sadman Sakib Saumik on 10/12/17.
//  Copyright © 2017 Sadman Sakib Saumik. All rights reserved.
//

import Foundation
import Firebase

class DataService {
    static let instance = DataService()
    
    private var _REF_BASE = BASE_URL
    private var _REF_USERS = BASE_URL.child("users")
    private var _REF_GROUPS = BASE_URL.child("groups")
    private var _REF_FEED = BASE_URL.child("feed")
    
    var REF_BASE: DatabaseReference {
        return _REF_BASE
    }
    var REF_USERS: DatabaseReference {
        return _REF_USERS
    }
    var REF_GROUPS: DatabaseReference {
        return _REF_GROUPS
    }
    var REF_FEED: DatabaseReference {
        return _REF_FEED
    }
    
    func createDBUser(uid: String, userData: Dictionary<String, Any>) {
        REF_USERS.child(uid).updateChildValues(userData)
    }
    
    func getUsername(uid : String, completion: @escaping CompletionHandlerGetUsername) {
        REF_USERS.observeSingleEvent(of: DataEventType.value) { (userDataSnapShot) in
            guard let userDataSnapShot = userDataSnapShot.children.allObjects as? [DataSnapshot] else {return}
            for user in userDataSnapShot {
                if user.key == uid {
                    completion(user.childSnapshot(forPath: "email").value as! String)
                }
            }
        }
    }
    
    func uploadPost(withMessage message: String, forId uid: String, withGroupKey groupKey: String?, completion: @escaping CompletionHandlerGeneral){
        if groupKey != nil {
            //with a group key
        } else {
                REF_FEED.childByAutoId().updateChildValues(["content": message, "senderId" : uid ])
                completion(true)
        }
    }
    
    func getAllFeedMessages(completion: @escaping CompletionHandlerMessage){
        var messageArray = [Message]()
        REF_FEED.observeSingleEvent(of: DataEventType.value) { (feedMessagesSnapshot) in
            guard let feedMessagesSnapshot = feedMessagesSnapshot.children.allObjects as? [DataSnapshot] else {return}
            for message in feedMessagesSnapshot {
                let content = message.childSnapshot(forPath: "content").value as! String
                let senderId = message.childSnapshot(forPath: "senderId").value as! String
                let message = Message(content: content, senderId: senderId)
                messageArray.append(message)
            }
            completion(messageArray)
        }
    }
    
    func getEmail(forQuery query: String, completion: @escaping CompletionHandlerGetEmail){
        var emailArray = [String]()
        REF_USERS.observe(DataEventType.value) { (userDataSnapshot) in
            guard let userSnapshot = userDataSnapshot.children.allObjects as? [DataSnapshot] else {return}
            for user in userSnapshot {
                let email = user.childSnapshot(forPath: "email").value as! String
                if email.contains(query) && Auth.auth().currentUser?.email != email {
                    emailArray.append(email)
                }
            }
            completion(emailArray)
        }
    }
    
}
