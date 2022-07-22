//
//  ViewModel.swift
//  SwiftUIPractice
//
//  Created by miori Lee on 2022/07/20.
//

import Foundation

class ViewModel: ObservableObject {
    var title: String = "Hello"
    // 배열에 새로운 요소가 삽입/삭제 될때 마다 새로운 배열을 방출
    @Published var list: [String] = [String]()
}
