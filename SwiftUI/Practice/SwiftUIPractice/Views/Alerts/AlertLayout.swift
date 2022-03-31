//
//  AlertLayout.swift
//  SwiftUIPractice
//
//  Created by miori Lee on 2022/03/27.
//

import SwiftUI

struct AlertLayout: View {
    @State private var msg : String = ""
    @State private var tColor : Color = .black
    @State private var showAlert : Bool = false
    @State private var showImageAlert : Bool = false
    
    @State private var imageData : ImageData? = nil
    
    var body: some View {
        VStack {
            Text(msg)
                .font(.largeTitle)
                .foregroundColor(tColor)
            Button {
                imageData = ImageData.sample
                //showImageAlert = true
                showAlert = true
            } label: {
                Text("Show Alert")
            }
            .padding()
            .alert("경고창", isPresented: $showAlert) {
                Button("확인") {
                    msg = "확인 눌렀구만"
                    tColor = .black
                }
                Button(role: .cancel) {
                    msg = "아잉 취소 버튼"
                    tColor = .black
                } label: {
                    Text("Cancel")
                }
                //빨간색으로 표시됨
//                Button(role: .destructive) {
//                    msg = "빨빨빨 빨간맛"
//                    tColor = .red
//                } label: {
//                    Text("Delete")
//                }


            } message: {
                Text("경고창에 표시될 메세지임")
            }
            // 데이터를 통해 alert
            .alert("참고할 데이터가 있다구", isPresented: $showImageAlert, presenting: imageData) { data in
                Button("필터 적용") {
                    msg = data.filters.joined(separator: ", ") + " 필터를 적용합니다"
                    tColor = .black
                }
                Button(role: .cancel) {
                    msg = "아잉 취소 버튼"
                    tColor = .black
                } label: {
                    Text("Cancel")
                }
                //빨간색으로 표시됨
                Button(role: .destructive) {
                    msg = "\(data.name) 삭제"
                    tColor = .red
                } label: {
                    Text("Delete")
                }
            } message: { data in
                Text("\(data.id) 파일에서 어떤 작업을 할까요?\n\n촬영일자 : \(data.date)")
            }

        }
    }
}

struct AlertLayout_Previews: PreviewProvider {
    static var previews: some View {
        AlertLayout()
    }
}
