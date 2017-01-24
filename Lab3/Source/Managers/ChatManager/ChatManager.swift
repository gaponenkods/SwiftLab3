//
//  ChatManager.swift
//  Lab3
//
//  Created by Konstantyn Byhkalo on 1/24/17.
//  Copyright © 2017 Gaponenko Dmitriy. All rights reserved.
//

import Foundation
import Alamofire

class ChatManager {
    
    static let sharedInstanse = ChatManager()
    
    func loadAllMessages(completionHandler: @escaping ([MessageModel]) -> ()) {
        var messageArray: [MessageModel] = []
        
        for index in 0...30 {
            let newMessageModel = MessageModel(author: "Author\(Double(index)*2.45)", message: "\(index*index)", timestamp: (Date().timeIntervalSinceReferenceDate - Double(index*index*2)))
            messageArray.append(newMessageModel)
        }
        
        DispatchQueue.global().asyncAfter(deadline: DispatchTime.now() + Double(Int64(3 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: {
            completionHandler(messageArray)
        })
    }
    
    func sendMessageBy(author: String, message: String, completionHandler: @escaping (Bool)->()) {
        
        DispatchQueue.global().asyncAfter(deadline: DispatchTime.now() + Double(Int64(3 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: {
            completionHandler(true)
        })
    }
    
}
