//
//  Label_Practice.swift
//  SwiftUIPractice
//
//  Created by miori Lee on 2022/07/26.
//

import SwiftUI

struct Label_Practice: View {
    var body: some View {
        VStack(spacing: 30) {
            HStack {
                Image(systemName: "person")
                Text("Profile")
            }
            .font(.largeTitle)
            
            Label("label 활용", systemImage: "person")
                .font(.largeTitle)
            
            HStack {
                Image("cj")
                    .resizable()
                    .aspectRatio(1.0, contentMode: .fit)
                    .frame(width: 100)
                    .clipShape(Circle())
                    .overlay {
                        Circle()
                            .stroke(lineWidth: 2)
                            .foregroundColor(.black)
                    }
                Text("Clean & Jerk")
                    .font(.largeTitle)
            }
            
            Label {
                Text("label 활용 c&j")
            } icon: {
                Image("cj")
                    .resizable()
                    .aspectRatio(1.0, contentMode: .fit)
                    .frame(width: 100)
                    .clipShape(Circle())
                    .overlay {
                        Circle()
                            .stroke(lineWidth: 2)
                            .foregroundColor(.black)
                    }
            }
            .font(.largeTitle)
        }
        .toolbar {
            Button {
                print("hello")
            } label: {
                Label("label 활용", systemImage: "person")
                    .labelStyle(.titleAndIcon)
            }

        }
    }
}

struct Label_Practice_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            Label_Practice()
                .navigationTitle("label 연습")
        }
    }
}
