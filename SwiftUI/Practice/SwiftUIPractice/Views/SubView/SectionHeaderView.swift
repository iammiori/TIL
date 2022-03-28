//
//  SectionHeaderView.swift
//  SwiftUIPractice
//
//  Created by miori Lee on 2022/03/25.
//

import SwiftUI

struct SectionHeaderView: View {
    let title : String
    var body: some View {
        HStack {
            Text(title)
                .foregroundColor(.black)
                .font(.title2)
            Spacer()
        }
        .padding()
        .frame(maxWidth : .infinity)
        .background(.gray)
    }
}

struct SectionHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        SectionHeaderView(title: "test")
    }
}
