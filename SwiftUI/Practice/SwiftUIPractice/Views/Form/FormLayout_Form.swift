//
//  FormLayout_Form.swift
//  SwiftUIPractice
//
//  Created by miori Lee on 2022/03/27.
//

import SwiftUI

struct FormLayout_Form: View {
    @State private var email : String = ""
    @State private var pwd : String = ""
    @State private var address : String = ""
    @State private var age : Int = 0
    @State private var acceptEmail : Bool = false
    
    @State private var selected : Bool = false
    
    //MARK: 방법 1.  새로운 환경 변수 설정
   // @Environment(\.presentationMode) var presentationMode
    
    //MARK: 방법 2.  ios 15 +
   // @Environment(\.dismiss) var dismiss
    
    //MARK: 방법 3. State variable 사용
    //@Binding var presentModal :  Bool
    
    // `@Binding var edited : Bool
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button {
                    //MARK: 방법 1.  presentationMode 에 접근후 dismiss호출
                    //presentationMode.wrappedValue.dismiss()
                    //MARK: 방법 2.  ios 15 +
                   // dismiss()
                    //MARK: 방법 3. State variable 사용
                    //presentModal = false
                } label: {
                    Text("닫기")
                }
                .padding(.trailing)
            }
            .frame(maxWidth : .infinity)
            Form {
                Section {
                    Text("미오리님")
                        .frame(maxWidth : .infinity)
                }
                .overlay(alignment: .trailing) {
                    if selected {
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundColor(.blue)
                            .font(.title2)
                    }
                }
                Section {
                    TextField("Email", text: $email)
//                        .onChange(of: email) { _ in
//                            edited = email != "" || pwd != "" || address != ""
//                        }
                    SecureField("Password", text: $pwd)
//                        .onChange(of: pwd) { _ in
//                            edited = email != "" || pwd != "" || address != ""
//                        }
                    TextField("Address",text: $address)
//                        .onChange(of: address) { _ in
//                            edited = email != "" || pwd != "" || address != ""
//                        }
                }
                Stepper("Age : \(age)", value: $age)
                Toggle(isOn: $acceptEmail) {
                    Text("수신 동의")
                }
                
                Section {
                    Button("확인"){
                        selected.toggle()
                    }
                    .frame(maxWidth : .infinity)
                }
            }
        }
    }
}


struct FormLayout_Form_Previews: PreviewProvider {
    static var previews: some View {
        FormLayout_Form()
        //MARK: 방법 3. State variable 사용 (정적으로 전달)
        //FormLayout_Form(presentModal: .constant(true))
        //FormLayout_Form(edited: .constant(false))
    }
}
