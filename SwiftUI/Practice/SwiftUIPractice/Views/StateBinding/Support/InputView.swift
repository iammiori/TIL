//
//  InputView.swift
//  SwiftUIPractice
//
//  Created by miori Lee on 2022/07/20.
//

import SwiftUI

struct InputView: View {
    //TwowayBinding의 value랑 binding 위해
    //@Binding
    //@State private var value: String = ""
    @Binding var value: String
    @State private var isEditing: Bool = false
    var body: some View {
        VStack {
            TextField("Value", text: $value, onEditingChanged: { isEditing = $0 })
                //.padding()
                .padding(.vertical, 12)
                .padding(.horizontal, 16)
                .textFieldStyle(.plain)
                .background(border)
        }
    }
    
    
    var border: some View {
      RoundedRectangle(cornerRadius: 16)
        .strokeBorder(
          LinearGradient(
            gradient: .init(
              colors: [
                Color.red,
                Color.blue
              ]
            ),
            startPoint: .topLeading,
            endPoint: .bottomTrailing
          ),
        lineWidth: isEditing ? 4 : 2
        )
    }
}

struct InputView_Previews: PreviewProvider {
    static var previews: some View {
        InputView(value: .constant("Hello"))
    }
}
