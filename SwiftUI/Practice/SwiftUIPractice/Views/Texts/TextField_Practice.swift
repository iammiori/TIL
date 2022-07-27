//
//  TextField_Practice.swift
//  SwiftUIPractice
//
//  Created by miori Lee on 2022/07/27.
//

import SwiftUI

enum FieldType: Hashable {
    case email
    case password
}

/*
 //MARK: TextField
 - 키보드 입력에 사용하는 기본적인 컨트롤
 - 한줄 입력에 특화
 */
struct TextField_Practice: View {
    @State private var email: String = ""
    @State private var password: String = ""
    
    @State private var showInputAlert: Bool = false
    @State private var showJoinAlert: Bool = false
    
//    @FocusState private var emailFocused: Bool
//    @FocusState private var passwordFocused: Bool
    @FocusState private var focusedField: FieldType?
    
    var body: some View {
        Form {
            Section {
                //mac OS에서 placeholder -> prompt
                TextField("Email", text: $email, prompt: Text("input Email"))
                    .textInputAutocapitalization(.never)
                    .disableAutocorrection(true)
                    //.focused($emailFocused)
                    .focused($focusedField, equals: .email)
                    .submitLabel(.next)
                    .onSubmit {
                        //passwordFocused = true
                        focusedField = .password
                    }
                SecureField("pwd",text: $password, prompt: Text("input Password"))
                    .textInputAutocapitalization(.never)
                    .disableAutocorrection(true)
                    //.focused($passwordFocused)
                    .focused($focusedField, equals: .password)
                    .submitLabel(.done)
                    .onSubmit {
                        checkVaild()
                    }
            }
            Section {
                Button {
                    checkVaild()
                } label: {
                    Text("Sign Up")
                }
                .frame(maxWidth: .infinity)
                .alert("회원가입", isPresented: $showJoinAlert) {
                    Button {
                        email = ""
                        password = ""
                    } label: {
                        Text("확인")
                    }
                } message: {
                    Text("계정 \(email)\n비밀번호\(password)")
                }
                .alert("경고", isPresented: $showInputAlert) {
                    Button {
                        //emailFocused = true
                        focusedField = .email
                    } label: {
                        Text("확인")
                    }

                } message: {
                    Text("이메일을 입력해주세요")
                }

            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                focusedField = .email
            }
        }
    }
    
    private func checkVaild() {
        if email.isEmpty {
            showInputAlert = true
        } else {
            showJoinAlert = true
            //emailFocused = false
            //passwordFocused = false
            focusedField = nil
        }
    }
}

struct TextField_Practice_Previews: PreviewProvider {
    static var previews: some View {
        TextField_Practice()
    }
}
