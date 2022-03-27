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
                    //고정여백
                    Spacer()
                        .frame(height: 30)
                    ForEach(0..<4) { EmojiView(number: $0) }
                } header: {
                    SectionHeaderView(title: "Sports")
                }
                Spacer()
                    .frame(height: 10)
                Section {
                    //고정여백
                    Spacer()
                        .frame(height: 30)
                    ForEach(4..<8) { EmojiView(number: $0)}
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

/*
 고정여백
 - VStack(spacing : ) ->  모두 다 적용
 - Spacing() .frame(height : 30 ) 개별 적용 (spacing에 modifier 추가)
 */
