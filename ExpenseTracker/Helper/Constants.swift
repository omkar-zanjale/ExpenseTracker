//
//  Constants.swift
//  ExpenseTracker
//
//  Created by admin on 30/12/22.
//

import Foundation

struct Constant {
    static var signUpFromFinger = false
    
    static func isEmailValid(email: String) -> Bool {
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: email)
    }
    
    static func isPasswordValid(password: String) -> Bool {
        if password.count >= 8 && password.count <= 16 {
            let regexForSpecialChar = ".*[^A-Za-z0-9].*"
            let alphaNumStr = NSPredicate(format:"SELF MATCHES %@", regexForSpecialChar)
            let isSpecialCharPresent = alphaNumStr.evaluate(with: password)
            let isNumberPresent = password.contains(where: {$0.isNumber})
            let isUppercasePresent = password.contains(where: {$0.isUppercase})
            let isWhitespacePresent = password.contains(where: {$0.isWhitespace})
            
            if isSpecialCharPresent && isNumberPresent && isUppercasePresent && !isWhitespacePresent {
                return true
            }
        }
        return false
    }
}

enum UserDefaultKeys: String {
    case isFingerActivated = "FingerprintActivated"
    case isNotFirstLaunch = "FirstLaunch"
    case currentUserName = "CurrentUserName"
    case currentUserPassword = "CurrentUserPassword"
}
