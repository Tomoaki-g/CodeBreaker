//
//  ContentView.swift
//  CodeBreaker
//
//  Created by takemoto on 2026/11/18.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack(alignment: .leading) {
            ForEach(0..<10, id: \.self) { index in
                pegs(num: Int.random(in: 3...6))

                if index != 9 {
                    Spacer()
                }
            }
        }
        .padding(.vertical)
        .padding(.horizontal, 16)
    }

    private func pegs(num: Int) -> some View {
        HStack(spacing: 8) {
            ForEach(0..<num, id: \.self) { _ in
                Circle()
                    .aspectRatio(1, contentMode: .fit)
                    .foregroundStyle(.black)
                    .frame(minWidth: 0, maxWidth: 45, maxHeight: 45)
            }

            MatchCircle(num: num, matches: Match.randomMatches(count: num))
                .fixedSize(horizontal: true, vertical: false)
        }
    }
}

#Preview {
    ContentView()
}
