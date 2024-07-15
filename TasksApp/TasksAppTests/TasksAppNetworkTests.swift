//
//  TasksAppNetworkTests.swift
//  TasksAppNetworkTests
//
//  Created by Роман Козловский on 11.07.2024.
//

import XCTest
@testable import TasksApp

final class TasksAppNetworkTests: XCTestCase {
    
    func testExpectationRealNetwork() {
        // GIVEN
        let didReceiveResponse = expectation(description: #function)
        let sut = WeatherNetworkManager()
        var result: Result<WeatherData?, Error>?
        
        //WHEN
        sut.makeRequest(type: WeatherData.self) {
            result = $0
            didReceiveResponse.fulfill()
        }
        
        wait(for: [didReceiveResponse], timeout: 3)
        
        //THEN
        switch result {
        case let .some(data):
            XCTAssertNotNil(data)
        case .none:
            XCTFail("Test failed")
        }
    }
    
    func testExpectationMockNetwork() {
        //GIVEN
        let mockNetwork = MockNetworkService()
        
        //THEN
        mockNetwork.makeRequest(type: String.self) { result in }
        
        //WHEN
        XCTAssertTrue(mockNetwork.executeCalled)
    }
}
