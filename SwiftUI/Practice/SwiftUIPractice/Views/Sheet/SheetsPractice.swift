//
//  SheetsPractice.swift
//  SwiftUIPractice
//
//  Created by miori Lee on 2022/03/28.
//

import SwiftUI

struct SheetsPractice: View {
    @State private var presentCardModal : Bool = false
    @State private var presentFullModal : Bool = false
    
    @State private var sportsData : SportsData?
    
    //Interactive Dismiss 막기위해
    @State private var edited : Bool = false
    var body: some View {
        VStack {
            Button {
                presentCardModal = true
            } label: {
                Text("Bool로 Card Modal")
            }
            .padding()
            .sheet(isPresented: $presentCardModal) {
                print("화면 닫고 일어날일")
            } content: {
                FormLayout_Form()
                //FormLayout_Form(presentModal: $presentCardModal)
                //FormLayout_Form(edited: $edited)
                    .interactiveDismissDisabled(edited)
                    //true : 비활성화
                //입력이되면 dismiss막았지만, 이후 경고창 띄우기나 이런거는 swiftUI에 아직 지원 안해줘서, UiKit으로 호스팅 한후 해야함
            }

            Button {
                presentFullModal = true
            } label: {
                Text("Bool로 Full Screen")
            }
            .padding()
            //MARK: fullscreen은 화면 닫는 코드 따로 작성 필요
            .fullScreenCover(isPresented: $presentFullModal) {
                
            } content: {
                FormLayout_Form()
                // FormLayout_Form(presentModal: $presentFullModal)
                //FormLayout_Form(edited: .constant(false))
            }
            
            //값의 유무로 표시할지 말지
            Button {
                sportsData = SportsData.samples[0]
            } label : {
                Text("item 전달")
            }
            .padding()
            .sheet(item: $sportsData) {
                
            } content: { data in
                EmojiView(number: data.movementIdx)
            }

        }
    }
}

struct SheetsPractice_Previews: PreviewProvider {
    static var previews: some View {
        SheetsPractice()
    }
}
