//
//  OnewayBinding.swift
//  SwiftUIPractice
//
//  Created by miori Lee on 2022/07/20.
//

import SwiftUI

struct OnewayBinding: View {
    @State private var text: String = "🚀 Oneway Binding"
    var body: some View {
        VStack(spacing: 70) {
            Text(text)
                .font(.title)
            Button {
                text = "Update 가즈아"
            } label: {
                Text("Update")
            }
            .padding()
        }
    }
}

struct OnewayBinding_Previews: PreviewProvider {
    static var previews: some View {
        OnewayBinding()
    }
}
