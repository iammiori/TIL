//
//  StickyHeaderView.swift
//  SwiftUIPractice
//
//  Created by miori Lee on 2022/03/25.
//

import SwiftUI

struct StickyHeaderView: View {
    var body: some View {
        ScrollView {
            LazyVStack(pinnedViews : [.sectionHeaders]) {
                Section {
                    ForEach(0..<4) { EmojiView(number: $0) }
                } header: {
                    SectionHeaderView(title: "Sports")
                }
                Section {
                    ForEach(4..<9) { EmojiView(number: $0)}
                } header: {
                    SectionHeaderView(title: "Foods")
                }
            }
            .frame(maxWidth : .infinity)
        }
    }
}

struct StickyHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        StickyHeaderView()
    }
}
