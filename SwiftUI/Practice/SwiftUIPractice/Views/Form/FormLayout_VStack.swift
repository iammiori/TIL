//
//  FormLayout_VStack.swift
//  SwiftUIPractice
//
//  Created by miori Lee on 2022/03/27.
//

import SwiftUI

struct FormLayout_VStack: View {
    @State private var email : String = ""
    @State private var pwd : String = ""
    @State private var address : String = ""
    @State private var age : Int = 0
    @State private var acceptEmail : Bool = false
    
    var body: some View {
        VStack {
            Group {
                TextField("Email", text: $email)
                SecureField("Password", text: $pwd)
                TextField("Address",text: $address)
            }
            .padding(.all)
            .border(Color(UIColor.separator))
            .padding(.leading)
            .padding(.trailing)
            Group {
                Stepper("Age : \(age)", value: $age)
                Toggle(isOn: $acceptEmail) {
                    Text("수신 동의")
                }
                Button("확인"){
                    
                }
                .frame(maxWidth : .infinity)
            }
            .padding()
        }
    }
}

struct FormLayout_VStack_Previews: PreviewProvider {
    static var previews: some View {
        FormLayout_VStack()
    }
}
