//
//  TasksAppUITests.swift
//  TasksAppUITests
//
//  Created by Роман Козловский on 11.07.2024.
//

import XCTest

final class TasksAppUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testMenuNavigation() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        
        app.navigationBars.buttons["list"].tap()
        app.cells.staticTexts["Countries"].tap()
        let cell = app.tables.cells.element(matching: .cell, identifier: "myCell_3")
        
        cell.tap()
        app.navigationBars.buttons["Countries"].tap()
        XCTAssertTrue(app.navigationBars.matching(identifier: "Countries").firstMatch.exists)
        
        app.navigationBars.buttons["list"].tap()
        app.cells.staticTexts["Погода"].tap()
        XCTAssertTrue(app.navigationBars.matching(identifier: "Погода").firstMatch.exists)
    }
    
    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
