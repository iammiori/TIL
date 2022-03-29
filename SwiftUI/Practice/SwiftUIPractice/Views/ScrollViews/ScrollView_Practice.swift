//
//  ScrollView_Practice.swift
//  SwiftUIPractice
//
//  Created by miori Lee on 2022/03/27.
//

import SwiftUI

struct ScrollView_Practice: View {
    var body: some View {
        ScrollView([.vertical, .horizontal], showsIndicators: false) {
            HStack {
                ForEach(0..<5) { _ in 
                    VStack {
                        ForEach(0..<32) {EmojiView(number: $0)}
                    }
                }
            }
        }
        .ignoresSafeArea()
    }
}

struct ScrollView_Previews: PreviewProvider {
    static var previews: some View {
        ScrollView_Practice()
    }
}
