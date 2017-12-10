//
//  AuthService.swift
//  BreakPoint
//
//  Created by Sadman Sakib Saumik on 10/12/17.
//  Copyright © 2017 Sadman Sakib Saumik. All rights reserved.
//

import Foundation
import Firebase

class AuthService{
    static let instance = AuthService()
 
    func registerUser(withEmail email:String, andPassword password: String, completion: @escaping CompletionHandler){
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            guard let user = user else {
                completion(false, error)
                debugPrint(error?.localizedDescription as Any)
                return
            }
            let userData = ["provider" : user.providerID, "email" : user.email]
            DataService.instance.createDBUser(uid: user.uid, userData: userData)
            completion(true, nil)
        }
    }
    func loginUser(withEmail email:String, andPassword password: String, completion: @escaping CompletionHandler){
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
//            guard let user = user else {
//                completion(false, error)
//                debugPrint(error?.localizedDescription as Any)
//                return
//            }
            
            if error != nil {
                completion(false, error)
                debugPrint(error?.localizedDescription as Any)
                return
            }
            completion(true, nil)
        }
    }
}
