//
//  Stack_Practice.swift
//  SwiftUIPractice
//
//  Created by miori Lee on 2022/03/24.
//

import SwiftUI

struct Stack_Practice: View {
    var body: some View {
        ZStack(alignment : .top) {
            Color.white
            HStack{
                //VStack을 leading으로 맞추기위해
                // 1. hstack
                // 2. Spacer()
                // 3. alignment : .leading
                Spacer()
                VStack(alignment: .trailing, spacing: 30.0) {
                    HStack(alignment : .center) {
                        heart
                        weightLift
                        kHeart
                    }
                    HStack(alignment : .center) {
                        kHeart
                        weightLift
                        kHeart
                    }
                    ScrollView(.horizontal) {
                        LazyHStack {
                            //stack은 포함된 모든 뷰를 동시에 초기화
                            //문제 : 서버통신 이미지 다운로드 ...
                            //해결 : LaztStaxk
                            //하지만 보통은 LazyGrid 더 사용
                            ForEach(1..<101) { num in
                                EmojiView(number: num)
                            }
                        }
                    }
                }
                //.frame(maxHeight: .infinity)
                //Spacer()
            }
        }
        .frame(maxWidth : .infinity, maxHeight: .infinity)
    }
    
    private var heart : some View {
        Image(systemName: "suit.heart.fill")
            .resizable()
            .frame(width: 50, height: 50)
            .foregroundColor(.red)
    }
    private var weightLift : some View {
        Text("🏋🏻‍♀️")
            .font(.largeTitle)
    }
    private var kHeart : some View {
        Text("🫰")
            .font(.largeTitle)
    }
}


struct Hstack_Practice_Previews: PreviewProvider {
    static var previews: some View {
        Stack_Practice()
    }
}
