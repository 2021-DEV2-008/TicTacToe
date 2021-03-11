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
            GeometryReader { proxy in
                VStack(spacing: margin) {
                    ForEach(0..<game.size, id: \.self) { line in
                        HStack(spacing: margin) {
                            ForEach(0..<game.size, id: \.self) { row in
                                Group {
                                    switch game.grid[line][row] {
                                    case .blank:
                                        Button(action: {}) {
                                            Image(systemName: "circle")
                                                .resizable()
                                                .opacity(0)
                                        }
                                    case .x:
                                        Image(systemName: "xmark")
                                            .resizable()
                                    case .o:
                                        Image(systemName: "circle")
                                            .resizable()
                                    }
                                }
                                .frame(width: pieceSize(in: proxy.size.width),
                                       height: pieceSize(in: proxy.size.width))
                                
                                if row < game.size - 1 {
                                    Divider().frame(maxHeight: pieceSize(in: proxy.size.width))
                                }
                            }
                        }
                        if line < game.size - 1 {
                            Divider()
                        }
                    }
                }
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
    
    private func pieceSize(in width: CGFloat) -> CGFloat {
        (width - (margin * ( 2 + ((CGFloat(game.size) - 1) * 2)))) / CGFloat(game.size)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
