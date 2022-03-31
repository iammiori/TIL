//
//  ActionSheet_Practice.swift
//  SwiftUIPractice
//
//  Created by miori Lee on 2022/03/28.
//

import SwiftUI

struct ActionSheet_Practice: View {
    @State private var showDialog = false
    @State private var emojiNum : Int = 0
    var body: some View {
        VStack {
            Spacer()
            EmojiView(number: emojiNum)
            Spacer()
            Button {
                showDialog = true
            } label: {
                Text("이모지 바꾸기")
            } //🏋🏻‍♀️","🤸‍♀️","🥊","🤺
            .padding()
            .confirmationDialog("경고창 제목(데이터모델)", isPresented: $showDialog, presenting: SportsData.samples) { sportsArr in
                //데이터 수와 상관없이 foreach로 해결 가능
                ForEach(sportsArr) { item in 
                    Button(item.movementName) {
                        emojiNum = item.movementIdx
                    }
                }
                Button(role: .cancel) {
                    
                } label: {
                    Text("취소")
                }
                Button(role: .destructive) {
                    emojiNum = 0
                } label: {
                    Text("Reset")
                }
            } message: { _ in
                //파라미터를 사용하지 않으므로 와일드카드(_)
                Text("메세지가 표시된다구")
            }

            
            
//            .confirmationDialog("경고창 제목", isPresented: $showDialog, titleVisibility: .automatic) {
//                Button("스내치") {
//                    emojiNum = 0
//                }
//                Button("물구나무") {
//                    emojiNum = 1
//                }
//                Button("복싱") {
//                    emojiNum = 2
//                }
//                Button(role: .cancel) {
//
//                } label: {
//                    Text("취소")
//                }
//                Button(role: .destructive) {
//                    emojiNum = 0
//                } label: {
//                    Text("Reset")
//                }
//
//
//            } message: {
//                Text("메세지가 표시된다구")
//            }

        }
    }
}

struct ActionSheet_Practice_Previews: PreviewProvider {
    static var previews: some View {
        ActionSheet_Practice()
    }
}
