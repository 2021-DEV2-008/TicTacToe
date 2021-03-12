//
//  ContentView.swift
//  Shared
//
//  Created by Jérôme Danthinne on 11/03/2021.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var game = GameEngine()
    @State private var newGameSize: Int = 3
    private let margin: CGFloat = 10
    
    var body: some View {
        VStack {
            HStack {
                Text("Current player:")
                if game.currentPlayer == .x {
                    Image(systemName: "xmark")
                } else {
                    Image(systemName: "circle")
                }
            }
            
            GeometryReader { proxy in
                VStack(spacing: margin) {
                    ForEach(0..<game.size, id: \.self) { line in
                        HStack(spacing: margin) {
                            ForEach(0..<game.size, id: \.self) { row in
                                Group {
                                    switch game.grid[row][line] {
                                    case .blank:
                                        Button(action: {
                                            guard game.gameEnd == nil else { return }
                                            game.makeMove(x: row, y: line, state: game.currentPlayer)
                                        }) {
                                            Image(systemName: "circle")
                                                .resizable()
                                                .opacity(0)
                                        }
                                    case .x:
                                        Image(systemName: "xmark")
                                            .resizable()
                                            .foregroundColor(.blue)
                                    case .o:
                                        Image(systemName: "circle")
                                            .resizable()
                                            .foregroundColor(.red)
                                    }
                                }
                                .frame(width: pieceSize(in: proxy.size),
                                       height: pieceSize(in: proxy.size))
                                
                                if row < game.size - 1 {
                                    Divider().frame(maxHeight: pieceSize(in: proxy.size))
                                }
                            }
                        }
                        if line < game.size - 1 {
                            Divider()
                        }
                    }
                }
            }
            
            switch game.gameEnd {
            case .draw:
                Text("It's a draw 😢")
            case .winnerX:
                Text("X's are the best! ☠️")
            case .winnerO:
                Text("O's rules! 🌝")
            case nil:
                Text("Game's on…")
            }
            
            HStack(spacing: 20) {
                Button("Start new game",
                       action: { game.startNewGame(ofSize: newGameSize) })
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.accentColor)
                    .cornerRadius(8)
                Stepper("Size: \(newGameSize)", value: $newGameSize, in: 2...10)
            }
        }
        .padding()
    }
    
    private func pieceSize(in size: CGSize) -> CGFloat {
        let minSize = min(size.width, size.height)
        return (minSize - (margin * ( 2 + ((CGFloat(game.size) - 1) * 2)))) / CGFloat(game.size)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
