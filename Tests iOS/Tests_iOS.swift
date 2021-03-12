//
//  Tests_iOS.swift
//  Tests iOS
//
//  Created by Jérôme Danthinne on 11/03/2021.
//

import XCTest

class Tests_iOS: XCTestCase {
    var gameEngine = GameEngine()
    
    override func setUpWithError() throws {
        gameEngine.startNewGame(ofSize: 3)
    }

    func testNewGameData() throws {
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
        
        // No winner yet.
        XCTAssertNil(gameEngine.gameEnd)
    }
    
    func testNewTurn() throws {
        // First player is always X.
        XCTAssertEqual(gameEngine.currentPlayer, .x)
        
        // After a new turn, player should be O.
        gameEngine.newTurn()
        XCTAssertEqual(gameEngine.currentPlayer, .o)
        
        // After a second turn, player should be set back to X.
        gameEngine.newTurn()
        XCTAssertEqual(gameEngine.currentPlayer, .x)
    }
    
    func testMakeMove() throws {
        gameEngine.makeMove(x: 0, y: 0, state: .x)
        
        // Check if position has been correctly set, and number of moves incremented
        XCTAssertEqual(gameEngine.grid[0][0], .x)
        XCTAssertEqual(gameEngine.numberOfMoves, 1)
        
        // Try to make another move to the same position.
        gameEngine.makeMove(x: 0, y: 0, state: .o)
        
        // The position should still be the first played state, and number of moves not incremented.
        XCTAssertEqual(gameEngine.grid[0][0], .x)
        XCTAssertEqual(gameEngine.numberOfMoves, 1)
    }
    
    func testEndOfGameWithRowFullOfXs() throws {
        gameEngine.makeMove(x: 0, y: 0, state: .x)
        XCTAssertNil(gameEngine.gameEnd)
        gameEngine.makeMove(x: 1, y: 0, state: .x)
        XCTAssertNil(gameEngine.gameEnd)
        gameEngine.makeMove(x: 2, y: 0, state: .x)
        
        // Row is full of X's, winner should be X.
        XCTAssertEqual(gameEngine.gameEnd, .winnerX)
    }
    
    func testEndOfGameWithLineFullOfOs() throws {
        gameEngine.makeMove(x: 0, y: 0, state: .o)
        XCTAssertNil(gameEngine.gameEnd)
        gameEngine.makeMove(x: 0, y: 1, state: .o)
        XCTAssertNil(gameEngine.gameEnd)
        gameEngine.makeMove(x: 0, y: 2, state: .o)
        
        // Line is full of O's, winner should be O.
        XCTAssertEqual(gameEngine.gameEnd, .winnerO)
    }
    
    func testEndOfGameWithWinningDiagonal() throws {
        gameEngine.makeMove(x: 0, y: 0, state: .x)
        XCTAssertNil(gameEngine.gameEnd)
        gameEngine.makeMove(x: 1, y: 1, state: .x)
        XCTAssertNil(gameEngine.gameEnd)
        gameEngine.makeMove(x: 2, y: 2, state: .x)
        
        // Line is mixed, game is not ended.
        XCTAssertEqual(gameEngine.gameEnd, .winnerX)
    }
    
    func testEndOfGameWithWinningInverseDiagonal() throws {
        gameEngine.makeMove(x: 0, y: 2, state: .o)
        XCTAssertNil(gameEngine.gameEnd)
        gameEngine.makeMove(x: 1, y: 1, state: .o)
        XCTAssertNil(gameEngine.gameEnd)
        gameEngine.makeMove(x: 2, y: 0, state: .o)
        
        // Line is mixed, game is not ended.
        XCTAssertEqual(gameEngine.gameEnd, .winnerO)
    }
    
    func testEndOfGameWithMixedRow() throws {
        gameEngine.makeMove(x: 0, y: 0, state: .x)
        XCTAssertNil(gameEngine.gameEnd)
        gameEngine.makeMove(x: 1, y: 0, state: .o)
        XCTAssertNil(gameEngine.gameEnd)
        gameEngine.makeMove(x: 2, y: 0, state: .x)
        
        // Line is mixed, game is not ended.
        XCTAssertNil(gameEngine.gameEnd)
    }

    func testEndOfGameWithNoWinner() throws {
        gameEngine.makeMove(x: 0, y: 0, state: .x)
        XCTAssertNil(gameEngine.gameEnd)
        gameEngine.makeMove(x: 1, y: 0, state: .o)
        XCTAssertNil(gameEngine.gameEnd)
        gameEngine.makeMove(x: 2, y: 0, state: .x)
        XCTAssertNil(gameEngine.gameEnd)
        gameEngine.makeMove(x: 0, y: 1, state: .x)
        XCTAssertNil(gameEngine.gameEnd)
        gameEngine.makeMove(x: 1, y: 1, state: .o)
        XCTAssertNil(gameEngine.gameEnd)
        gameEngine.makeMove(x: 2, y: 1, state: .x)
        XCTAssertNil(gameEngine.gameEnd)
        gameEngine.makeMove(x: 0, y: 2, state: .o)
        XCTAssertNil(gameEngine.gameEnd)
        gameEngine.makeMove(x: 1, y: 2, state: .x)
        XCTAssertNil(gameEngine.gameEnd)
        gameEngine.makeMove(x: 2, y: 2, state: .o)
        
        // All positions played.
        XCTAssertEqual(gameEngine.gameEnd, .draw)
    }
}
