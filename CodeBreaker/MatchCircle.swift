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

    static func randomMatches(count: Int) -> [Match] {
        guard count > 0 else { return [] }

        return (0..<count).map { _ in
            Match.allCases.randomElement()!
        }
    }
}

struct MatchCircle: View {
    let num: Int
    var matches: [Match]

    var body: some View {
        HStack {
            ForEach(Array(stride(from: 0, to: num, by: 2)), id: \.self) { start in
                CircleRaw(start: start, num: min(2, num - start))
            }
        }
    }

    private func matchMarker(peg: Int) -> some View {
        let match = matches.indices.contains(peg) ? matches[peg] : .nomatch

        return Circle()
            .fill(match == .exact ? Color.primary : Color.clear)
            .strokeBorder(match == .inexact ? Color.primary : Color.clear, lineWidth: 2)
            .aspectRatio(1, contentMode: .fit)
            .frame(width: 20)
    }

    private func CircleRaw(start:Int, num: Int) -> some View {
        VStack {
            matchMarker(peg: start)
            matchMarker(peg: start + 1)
                .opacity(num == 2 ? 1 : 0)
        }
    }
}

#Preview {
    MatchCircle(num: 4, matches: [.exact, .inexact, .exact, .nomatch])
}
