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

    enum GameEnd {
        case winnerX
        case winnerO
        case draw
    }

    @Published private(set) var size: Int = 3
    @Published private(set) var grid = [[State]]()
    @Published private(set) var gameEnd: GameEnd?
    private(set) var currentPlayer: State = .x
    private(set) var numberOfMoves: Int = 0

    init() {
        startNewGame(ofSize: size)
    }

    func startNewGame(ofSize size: Int) {
        objectWillChange.send()

        self.size = size
        grid = Array(repeating: Array(repeating: .blank,
                                      count: size),
                     count: size)
        currentPlayer = .x
        numberOfMoves = 0
        gameEnd = nil
    }

    func makeMove(x: Int, y: Int, state: State) {
        // Check if position hasn't been played yet.
        guard grid[x][y] == .blank else {
            return
        }

        objectWillChange.send()

        // Set new state at position.
        grid[x][y] = state

        // Increment the number of moves
        numberOfMoves += 1

        // Check end of game.
        if let gameEnd = checkGameEnd(withLastMoveAtX: x, y: y) {
            self.gameEnd = gameEnd
        } else {
            newTurn()
        }
    }

    func newTurn() {
        currentPlayer = currentPlayer == .x ? .o : .x
    }

    func checkGameEnd(withLastMoveAtX x: Int, y: Int) -> GameEnd? {
        // Check played row.
        let row = grid[x]
        if let winningRow = checkWinner(in: row) {
            return winningRow
        }

        // Check played line.
        let line = grid.map { $0[y] }
        if let winningLine = checkWinner(in: line) {
            return winningLine
        }

        // If on the diagonal, check it.
        if x == y {
            let diagonal = grid.enumerated().map { $0.element[$0.offset] }
            if let winningDiagonal = checkWinner(in: diagonal) {
                return winningDiagonal
            }
        }

        // If on the inverse diagonal, check it.
        if x + 1 == size - y {
            let inverseDiagonal = grid.enumerated().map { $0.element[size - 1 - $0.offset] }
            if let winningDiagonal = checkWinner(in: inverseDiagonal) {
                return winningDiagonal
            }
        }

        // If all positions have been played, it's a draw.
        if numberOfMoves == size * size {
            return .draw
        }

        return nil
    }

    private func checkWinner(in items: [State]) -> GameEnd? {
        // If items not fully played, no winner.
        guard !items.contains(.blank) else { return nil }

        let sum = items.reduce(0) { $0 + $1.rawValue }

        if sum == State.x.rawValue * size {
            // Full of X's
            return .winnerX
        } else if sum == State.o.rawValue * size {
            // Full of O's
            return .winnerO
        } else {
            // Mix of O's and X's
            return nil
        }
    }
}
