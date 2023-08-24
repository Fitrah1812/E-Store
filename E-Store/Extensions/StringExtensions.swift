//
//  StringExtensions.swift
//  E-Store
//
//  Created by Laptop MCO on 14/08/23.
//

import Foundation

extension String {
    var isEmail: Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailPred = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: self)
    }
    
    var isPassowrd: Bool {
        let passwordRegEx = "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{8,}$"
        
        let passwordPred = NSPredicate(format: "SELF MATCHES %@", passwordRegEx)
        return passwordPred.evaluate(with: self)
    }
    
}
