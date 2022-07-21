//
//  TwowayBinding.swift
//  SwiftUIPractice
//
//  Created by miori Lee on 2022/07/20.
//

import SwiftUI

struct TwowayBinding: View {
    @State private var value: String = "🏋🏻‍♀️로말..갖고싶다"
    var body: some View {
        VStack(spacing: 70) {
            Text(value)
                .font(.headline)
            
//            TextField("입력", text: $value, onEditingChanged: { isEditing = $0 })
//                //.padding()
//                .padding(.vertical, 12)
//                .padding(.horizontal, 16)
//                .textFieldStyle(.plain)
//                .background(border)
            InputView(value: $value)
        }
    }
}

struct TwowayBinding_Previews: PreviewProvider {
    static var previews: some View {
        TwowayBinding()
    }
}
