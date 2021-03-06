//
//  TwowayBinding.swift
//  SwiftUIPractice
//
//  Created by miori Lee on 2022/07/20.
//

import SwiftUI

struct TwowayBinding: View {
    @State private var value: String = "ππ»ββοΈλ‘λ§..κ°κ³ μΆλ€"
    var body: some View {
        VStack(spacing: 70) {
            Text(value)
                .font(.headline)
            
//            TextField("μλ ₯", text: $value, onEditingChanged: { isEditing = $0 })
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
