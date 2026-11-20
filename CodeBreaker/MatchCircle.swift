//
//  MatchCircle.swift
//  CodeBreaker
//
//  Created by takemoto on 2026/11/18.
//

import SwiftUI

enum Match: CaseIterable {
    case nomatch
    case exact
    case inexact
}

struct MatchCircle: View {
    var matches: [Match]
    var num: Int = 6
    
    var body: some View {
        HStack {
            VStack {
                matchMarker(peg: 0)
                matchMarker(peg: 1)
            }
            VStack {
                matchMarker(peg: 2)
                matchMarker(peg: 3)
            }
            VStack {
                matchMarker(peg: 4)
                matchMarker(peg: 5)
            }
        }
    }

    private func matchMarker(peg: Int) -> some View {
        let exactCount = matches.count { $0 == .exact }
        let foundCount = matches.count { $0 != .nomatch }

        return Circle()
            .fill(exactCount > peg ? Color.primary : Color.clear)
            .strokeBorder(
                foundCount > peg ? Color.primary : Color.gray.opacity(0.3),
                lineWidth: 2
            )
            .aspectRatio(1, contentMode: .fit)
    }
}

#Preview {
    MatchCircle(matches: [.exact, .inexact, .exact, .nomatch, .exact, .nomatch])
}
