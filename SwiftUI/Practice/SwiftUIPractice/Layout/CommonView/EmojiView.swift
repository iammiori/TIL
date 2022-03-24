//
//  EmojiView.swift
//  SwiftUIPractice
//
//  Created by miori Lee on 2022/03/24.
//

import SwiftUI

struct EmojiView: View {
    let emoji : String
    let emojiArr : [String] = ["🏋🏻‍♀️","🤸‍♀️","🚀","👩🏻‍💻","☄️"]
    
    init(number: Int) {
        self.emoji = emojiArr[number % 5]
        print("EmojiView \(number) initialized")
    }
    
    var body: some View {
        Text(emoji)
            .font(.system(size: 50))
            .frame(width: 150, height: 150)
            .background(.gray)
            .clipShape(Circle())
    }
}

struct NumberView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiView(number: 1)
    }
}
