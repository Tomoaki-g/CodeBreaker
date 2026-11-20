//
//  CodeBreakerView.swift
//  CodeBreaker
//
//  Created by takemoto on 2026/11/18.
//

import SwiftUI

struct CodeBreakerView: View {
    @State var game = CodeBreaker()
    
    var body: some View {
        VStack {
            restartButton
                .padding(.bottom, 16)
            
            view(for: game.maseterCode)
            
            ScrollView {
                VStack(spacing: 4) {
                    view(for: game.guess)
                    
                    ForEach(game.attempts.indices.reversed(), id: \.self) { index in
                        view(for: game.attempts[index])
                    }
                }
            }
        }
        .padding(.horizontal, 8)
        .padding(.vertical)
    }
    
    var guessButton: some View {
        Button("Guess") {
            withAnimation {
                game.attemptGuess()
            }
        }
        .font(.system(size: 24))
        .fixedSize()
        .disabled(game.guess.pegs.contains(Code.missing))
    }
    
    var restartButton: some View {
        Button {
            game.reset()
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
        HStack(spacing: 4) {
            ForEach(code.pegs.indices, id: \.self) { index in
                RoundedRectangle(cornerRadius: 10)
                    .fill(.clear)
                    .overlay {
                        if code.pegs[index] == Code.missing {
                            RoundedRectangle(cornerRadius: 10)
                                .strokeBorder(.gray)
                        } else {
                            Text(code.pegs[index])
                                .font(.system(size: 40))
                                .minimumScaleFactor(0.1)
                                .lineLimit(1)
                        }
                    }
                    .aspectRatio(1, contentMode: .fit)
                    .frame(minWidth: 0, maxWidth: 75)
                    .frame(height: code.kind == .master ? 75 : 55)
                    .contentShape(Rectangle())
                    .onTapGesture {
                        if code.kind == .guess {
                            game.changeGuessPeg(at: index)
                        }
                    }
            }

            Spacer(minLength: 0)

            Group {
                if code.kind == .guess {
                    guessButton
                } else {
                    MatchCircle(matches: code.matches, num: code.pegs.count)
                }
            }
            .frame(width: 70, height: 55, alignment: .trailing)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    CodeBreakerView()
}
