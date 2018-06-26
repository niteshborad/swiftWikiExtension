//
//  DateExtension_KOR.swift
//  dfae
//
//  Created by maccli1 on 2018. 6. 26..
//  Copyright © 2018년 myoung. All rights reserved.
//
import Foundation
import UIKit

extension Date {
 
    func dateToString(_ format: String) -> String {
        /*
         - A Member function that convert the date type to the string type
         - Return type is 'String'
         - ex) Date().dateToString("yyMMdd") -> 180626
        */

        let formatter = DateFormatter()
        formatter.dateFormat = format
        let value = formatter.string(from: self)
        
        return value
    }
    
}
