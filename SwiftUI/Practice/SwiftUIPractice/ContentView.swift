//
//  ContentView.swift
//  SwiftUIPractice
//
//  Created by miori Lee on 2022/03/23.
//

import SwiftUI

struct ContentView: View {
    //MARK: 상태바꿔서 속성 변경
    /*
     - 주의할 점 :
        - 반복적으로 생성되므로, 초기화코드가 느리면 딜레이 발생 가능 -> 초기화 코드는 가벼워야함
        - 이니셜라이저를 구현하지 않고 멤버와이즈 이니셜라이저를 사용해서 필요한 속성만 초기화
     */
    @State var data : String = ":)"
    //MARK: view역할
    /*
     - UI를 구성하는 가장 기본적인 요소
     역할 1. 화면에서 특정 부분에 원하는 데이터나 상태 표시
     역할 2. 여러개의 view가 모여 하나의 화면 구성
     - 코드레벨에서
        - UIKit에서 view는 클래스로 구현 (다양한 멤버가 상속, 따라서 크고 무거움)
        - swiftUI에서는 상속하는 멤버 없음
        - 값형식으로 구현 -> 레퍼런스 카운팅 같은 오버헤드도 없음 -> 가볍고 레이아웃 성능 높음
     - body 속성을 computed property
     */
    var body: some View {
        //Opaque(오페이크)타입
        //view프로토콜을 채용한 view를 리턴
        ZStack{
            //다크모드 해결
            Color.white
                .edgesIgnoringSafeArea(.all)
            VStack {
                Text(data)
                    //modifier : View를 리턴
//                    .font(.largeTitle)
//                    .padding()
                    .background(.yellow)
                Text("🫠")
//                    .font(.largeTitle)
                Button {
                    data = "\(Int.random(in: 1 ... 100))"
                }  label: {
                    Text("Update")
                        .bold()
                }
            }
            //chain 가능
            //왜? modifier가 view리턴
            .padding()
            .font(.largeTitle)
        }
        
        .onAppear {
            //생명주기도 modifier
        }
        .onDisappear {
            //생명주기도 modifier
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        if #available(iOS 15.0, *) {
            //preview 돌리는 건 ios15부터
            ContentView()
                .previewInterfaceOrientation(.portrait)
        } else {
            ContentView()
        }
    }
}
