//
//  CodeBreaker.swift
//  CodeBreaker
//
//  Created by takemoto on 2026/11/19.
//

import SwiftUI

typealias Peg = Color

struct CodeBreaker {
    var maseterCode: Code = Code(kind: .master)
    var guess: Code = Code(kind: .guess)
    var attempts: [Code]  = [Code]()
    let pegsChoices: [Peg]
    
    init(pegsChoices: [Peg] = [.red, .green, .blue, .yellow]) {
        self.pegsChoices = pegsChoices
        maseterCode.randomize(from: pegsChoices)
        print(maseterCode)
    }
    
    mutating func changeGuessPeg(at index: Int) {
        let existingPeg = guess.pegs[index]
        if let indexOfExistingPegInPegChoices = pegsChoices.firstIndex(of: existingPeg) {
            let newPeg = pegsChoices[(indexOfExistingPegInPegChoices + 1) % pegsChoices.count]
            guess.pegs[index] = newPeg
        } else {
            guess.pegs[index] = pegsChoices.first ?? Code.missing
        }
    }
    
    mutating func attemptGuess() {
        var attempt = guess
        attempt.kind = .attempt(guess.match(against: maseterCode))
        attempts.append(attempt)
    }
}

struct Code {
    var kind: Kind
    var pegs: [Peg] = Array(repeating: Code.missing, count: 4)

    static let missing: Peg = .clear
    
    enum Kind: Equatable {
        case master
        case guess
        case attempt([Match])
        case unknown
    }
    
    mutating func randomize(from pegChoices: [Peg]) {
        for index in pegChoices.indices {
            pegs[index] = pegChoices.randomElement() ?? Code.missing
        }
    }
    
    var matches: [Match] {
        switch kind {
        case .attempt(let matches): return matches
        default: return []
        }
    }
    
    func match(against otherCode: Code) -> [Match] {
        var results: [Match] = Array(repeating: .nomatch, count: pegs.count)
        var pegsToMatch = otherCode.pegs
        
        for index in pegs.indices.reversed() {
            if pegsToMatch.count > index, pegsToMatch[index] == pegs[index] {
                results[index] = .exact
                pegsToMatch.remove(at: index)
            }
        }
        
        for index in pegs.indices {
            if let matchIndex = pegsToMatch.firstIndex(of: pegs[index]) {
                results[index] = .inexact
                pegsToMatch.remove(at: matchIndex)
            }
        }
        
        return results
    }
}
