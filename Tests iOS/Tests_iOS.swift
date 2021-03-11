//
//  Tests_iOS.swift
//  Tests iOS
//
//  Created by Jérôme Danthinne on 11/03/2021.
//

import XCTest

class Tests_iOS: XCTestCase {
    var gameEngine = GameEngine()

    func testNewGameData() throws {
        gameEngine.startNewGame(ofSize: 3)
        
        // Size should be 3.
        XCTAssertEqual(gameEngine.size, 3)
        
        // Get all states
        let allStates = gameEngine.grid.flatMap { $0 }
        
        // Total number of states should be 3*3 = 9.
        XCTAssertEqual(allStates.count, 9)
        
        // Total of state values should be set back to 0.
        XCTAssertEqual(allStates.map(\.rawValue).reduce(0, +), 0)
        
        // Number of moves should be set back to 0.
        XCTAssertEqual(gameEngine.numberOfMoves, 0)
    }
}
