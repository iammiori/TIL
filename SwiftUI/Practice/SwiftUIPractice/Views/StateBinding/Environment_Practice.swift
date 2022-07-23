//
//  Environment_Practice.swift
//  SwiftUIPractice
//
//  Created by miori Lee on 2022/07/20.
//

import SwiftUI

struct Environment_Practice: View {
    //darkmode or lightmode
    @Environment(\.colorScheme) var currentColorScheme
    @Environment(\.horizontalSizeClass) var currentHorizontalSizeClass
    var body: some View {
        List {
            Group {
                HStack {
                    Text("Color Scheme")
                    Spacer()
                    Text(currentColorScheme == .dark ? "Dark" : "Light")
                }
                HStack {
                    Text("Horizontal Size Class")
                    Spacer()
                    Text(currentHorizontalSizeClass == .compact ? "compact" : "regular")
                }
            }
            .padding()
        }
    }
}

struct Environment_Previews: PreviewProvider {
    static var previews: some View {
        Environment_Practice()
            .previewInterfaceOrientation(.portrait)
            
    }
}
