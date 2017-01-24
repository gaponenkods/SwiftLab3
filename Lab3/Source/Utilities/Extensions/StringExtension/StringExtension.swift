//
//  StringExtension.swift
//  Lab3
//
//  Created by Konstantyn Byhkalo on 1/24/17.
//  Copyright © 2017 Gaponenko Dmitriy. All rights reserved.
//

import Foundation

extension String {
    
//    var localized: String {
//        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
//    }
    
//    func localized() -> String {
//        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
//    }
    
    func localizedWithComment(comment:String) -> String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: comment)
    }
    func localized() -> String {
        return String(format: NSLocalizedString(self, comment: self))
    }
}
