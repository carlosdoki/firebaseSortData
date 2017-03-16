//
//  Message.swift
//  firebaseSortData
//
//  Created by Carlos Doki on 16/03/17.
//  Copyright © 2017 Carlos Doki. All rights reserved.
//

import Foundation

class Message {
    var msgId: String!
    var msgText: String!
    var postedDate: String!
    
    init(msgId: String, msgData: [String: AnyObject]) {
        self.msgId = msgId
        
        if let msgText = msgData["text"] as? String {
            self.msgText = msgText
        }
        
        if let postedDate = msgData["postedDate"] as? String {
            self.postedDate = postedDate
        }
    }
}
