//
//  CodeBreakerView.swift
//  CodeBreaker
//
//  Created by takemoto on 2026/11/18.
//

import SwiftUI

struct CodeBreakerView: View {
    @State var game = CodeBreaker(pegsChoices: [.brown, .yellow, .orange, .black])
    
    var body: some View {
        VStack {
            restartButton
                .padding(.bottom, 16)
            
            view(for: game.maseterCode)
            
            ScrollView {
                view(for: game.guess)
                
                ForEach(game.attempts.indices.reversed(), id: \.self) { index in
                    view(for: game.attempts[index])
                }
            }
        }
        .padding()
    }
    
    var guessButton: some View {
        Button("Guess") {
            withAnimation {
                game.attemptGuess()
            }
        }
        .font(.system(size: 80))
        .minimumScaleFactor(0.1)
    }
    
    var restartButton: some View {
        Button {
            game.attempts = []
        } label: {
            Text("Restart")
                .font(.system(size: 30))
                .minimumScaleFactor(0.1)
                .padding(.horizontal, 20)
                .padding(.vertical, 10)
        }
        .foregroundStyle(.black)
        .background {
            RoundedRectangle(cornerRadius: 8)
                .fill(.white)
                .shadow(color: .black.opacity(0.5), radius: 3, x: 0, y: 2)
        }
        .buttonBorderShape(.roundedRectangle(radius: 8))
    }

    func view(for code: Code) -> some View {
        HStack {
            ForEach(code.pegs.indices, id: \.self) { index in
                RoundedRectangle(cornerRadius: 10)
                    .overlay {
                        if code.pegs[index] == Code.missing {
                            RoundedRectangle(cornerRadius: 10)
                                .strokeBorder(.gray)
                        }
                    }
                    .contentShape(Rectangle())
                    .aspectRatio(1, contentMode: .fit)
                    .foregroundStyle(code.pegs[index])
                    .onTapGesture {
                        if code.kind == .guess {
                            game.changeGuessPeg(at: index)
                        }
                    }
            }

            MatchCircle(matches: code.matches)
                .overlay {
                    if code.kind == .guess {
                        guessButton
                    }
                }
        }
    }
}

#Preview {
    CodeBreakerView()
}
