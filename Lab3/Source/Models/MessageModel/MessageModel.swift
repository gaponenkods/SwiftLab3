//
//  MessageModel.swift
//  Lab3
//
//  Created by Konstantyn Byhkalo on 1/24/17.
//  Copyright © 2017 Gaponenko Dmitriy. All rights reserved.
//

import Foundation
import UIKit

class MessageModel {
    
    let author: String
    let message: String
    let timestamp: TimeInterval

    init(author: String, message: String, timestamp: TimeInterval) {
        self.author = author
        self.message = message
        self.timestamp = timestamp
    }
    
    func configureCell(cell: UITableViewCell) -> UITableViewCell {
        //    „NNN minutes ago”
        //    „Author says: Message text”
        
        let timeDelta = Date().timeIntervalSinceReferenceDate - timestamp
        let minuteTimeDelta = timeDelta / 60.0
        
        var timeText = ""
        if minuteTimeDelta < 1 {
            // seconds presentation
            
            timeText = String(format: NSLocalizedString("%.0f seconds ago", comment: "seconds ago"), timeDelta)
//            timeText = "\(String(format: "%.0f", timeDelta)) seconds ago"
        } else if minuteTimeDelta > 59 {
            // hour presentation
            timeText = String(format: NSLocalizedString("%.0f hours ago", comment: "hours ago"), Int(minuteTimeDelta / 60))
//            timeText = "\(Int(minuteTimeDelta / 60)) hours ago"
        } else {
            // minute presentation
            timeText = String(format: NSLocalizedString("%.0f minutes ago", comment: "minutes ago"), minuteTimeDelta)
//            timeText = "\(String(format: "%.0f", minuteTimeDelta)) minutes ago"
            
        }
        
        let messageText = String(format: NSLocalizedString("%@ says: %@", comment: "Author says: Message text"), author, message)
//        let messageText = "\(author) says: \(message)"
        
        cell.textLabel?.text = timeText
        cell.detailTextLabel?.text = messageText
        
        return cell
    }
    
}
