//
//  GameEngine.swift
//  TicTacToe
//
//  Created by Jérôme Danthinne on 11/03/2021.
//

import Foundation

class GameEngine: ObservableObject {
    enum State: Int {
        case blank = 0
        case x = 1
        case o = 2
    }
    
    @Published private(set) var size: Int = 3
    @Published private(set) var grid = [[State]]()
    private(set) var currentPlayer: State = .x
    private(set) var numberOfMoves: Int = 0
    
    init() {
        startNewGame(ofSize: size)
    }
    
    func startNewGame(ofSize size: Int) {
        self.objectWillChange.send()
        
        self.size = size
        grid = Array(repeating: Array(repeating: .blank,
                                      count: size),
                     count: size)
        currentPlayer = .x
        numberOfMoves = 0
    }
    
    func makeMove(x: Int, y: Int, state: State) {
        // Check if position hasn't been played yet.
        guard grid[x][y] == .blank else {
            return
        }
        
        // Set new state at position.
        grid[x][y] = state
        
        // Increment the number of moves
        numberOfMoves += 1
    }
    
    func newTurn() {
        currentPlayer = currentPlayer == .x ? .o : .x
    }
}
