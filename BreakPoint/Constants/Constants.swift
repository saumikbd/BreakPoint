//
//  File.swift
//  BreakPoint
//
//  Created by Sadman Sakib Saumik on 10/12/17.
//  Copyright © 2017 Sadman Sakib Saumik. All rights reserved.
//

import Foundation
import Firebase

//Completion Handlers
typealias CompletionHandler = (_ Status:Bool, _ error: Error?) -> ()
typealias CompletionHandlerGeneral = (_ Status:Bool) -> ()
typealias CompletionHandlerMessage = (_ messageArray:[Message]) -> ()
typealias CompletionHandlerGetUsername = (_ username:String) -> ()
typealias CompletionHandlerGetEmail = (_ emailArray:[String])->()
typealias CompletionHandlerGetUid = (_ uidArray:[String])->()
typealias CompletionHandlerGetGroups = (_ userGroups: [Group])->()

//URLS
let BASE_URL = Database.database().reference()

