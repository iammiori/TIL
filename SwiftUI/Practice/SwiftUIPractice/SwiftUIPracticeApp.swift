//
//  SwiftUIPracticeApp.swift
//  SwiftUIPractice
//
//  Created by miori Lee on 2022/03/23.
//

import SwiftUI

//MARK: @main 역할
/*
 컴파일러가 main함수를 자동으로 합성
 main 함수 : os가 가장 먼저 실행, 초기화 담당
 플랫폼에 적합하게 초기화 진행
 */
@main
struct SwiftUIPracticeApp: App {
    //App 프로토콜 채용
    var body: some Scene {
        MyScene()
    }
}

struct MyScene : Scene {
    //MARK: Scene의 상태
    @Environment(\.scenePhase) private var scenePhase
    
    var body: some Scene {
        //body 속성
        //scene : 뷰계층을 담고 있는 컨테이너
        WindowGroup {
            ContentView()
        }
        .onChange(of: scenePhase) { phase in
            if phase == .background {
                //캐시비우는 코드
            }
        }
    }
}
