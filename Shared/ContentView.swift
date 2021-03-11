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
    
    var body: some View {
        VStack {
            HStack(spacing: 20) {
                Button("Start new game",
                       action: { game.startNewGame(ofSize: newGameSize) })
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.accentColor)
                    .cornerRadius(8)
                Stepper("Size: \(newGameSize)", value: $newGameSize)
            }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
