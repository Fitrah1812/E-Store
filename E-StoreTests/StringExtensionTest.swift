//
//  StringExtensionTest.swift
//  E-StoreTests
//
//  Created by Laptop MCO on 21/08/23.
//

import XCTest
@testable import E_Store

final class StringExtensionTest: XCTestCase {

    final class StringExtensionTests: XCTestCase {
        func test_isSecurePassword_whenCharslessThan8(){
            let password: String = "1234"
            XCTAssertFalse(password.isPassowrd, "\(password) is not sercure")
        }
        
        func test_isSecurePassword_whenCharslessThan8_2(){
            let password: String = "jambo"
            XCTAssertFalse(password.isPassowrd, "\(password) is not sercure")
        }
    }
}
