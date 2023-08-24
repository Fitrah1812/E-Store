//
//  ApiServiceTests.swift
//  E-StoreTests
//
//  Created by Laptop MCO on 21/08/23.
//

import XCTest
@testable import E_Store

final class ApiServiceTests: XCTestCase {

    func test_loadCategoryList() {
        let apiService = ApiService()
        let expectation = XCTestExpectation(description: "Test get category list")
        
        apiService.loadCategoryList { (categoryList) in
            XCTAssert(categoryList.count > 0, "Category list is empty")
            expectation.fulfill()
        }
        wait(for: [expectation])
        
    }
    
    func test_login_whenEmailOrPasswordInvalid() {
        let apiService = ApiService()
        let email = "john@mail.comi"
        let password = "changeme"
        let expectation = XCTestExpectation(description: "Test Login Negatif")
        
        apiService.login(email: email, password: password) { (result) in
            switch result {
            case .success(let accessToken):
                XCTAssert(false, "Login should Failed")
            case .failure:
                break
            }
            expectation.fulfill()
        }
    }
    
    func test_login_whenEmailOrPasswordSuccess() {
        let apiService = ApiService()
        let email = "john@mail.com"
        let password = "changeme"
        let expectation = XCTestExpectation(description: "Test Login Positive")
        
        apiService.login(email: email, password: password) { (result) in
            switch result {
            case .success(let accessToken):
                XCTAssert(!accessToken.accessToken.isEmpty, "Access token is empty")
                XCTAssert(!accessToken.refreshToken.isEmpty, "Access token is empty")
            case .failure:
                XCTAssert(false, "Login Should Success")
            }
            expectation.fulfill()
        }
        wait(for: [expectation])
    }

}
