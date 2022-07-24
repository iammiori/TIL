//
//  Text_Practice.swift
//  SwiftUIPractice
//
//  Created by miori Lee on 2022/07/24.
//

import SwiftUI

struct Text_Practice: View {
    var body: some View {
        VStack {
            Text("Hello")
        }
    }
}

struct Text_Practice_Previews: PreviewProvider {
    static var previews: some View {
        Text_Practice()
            .environment(\.locale, Locale(identifier: "ko_kr"))
    }
}
