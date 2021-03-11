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
    
    @Published private(set) var size: Int = 0
    @Published private(set) var grid = [[State]]()
    private(set) var numberOfMoves: Int = 0
    
    func startNewGame(ofSize size: Int) {
        self.size = size
        grid = Array(repeating: Array(repeating: .blank,
                                      count: size),
                     count: size)
        numberOfMoves = 0
    }
}
