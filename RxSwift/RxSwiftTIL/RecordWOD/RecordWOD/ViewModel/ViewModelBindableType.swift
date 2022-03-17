//
//  ViewModelBindableType.swift
//  RecordWOD
//
//  Created by miori Lee on 2022/03/17.
//

import UIKit

//MARK: viewModel과 view 바인딩 위한 프로토콜 선언
/*
 - MVVM으로 구현할떄,
 - viewModel을 VC의 속성으로 구현
 - viewModel과 view 바인딩 위한 프로토콜 선언
 */
protocol ViewModelBindableType {
    //viewModel은 vc마다 달라짐
    //프로토콜을 제네릭으로 선언
    associatedtype ViewModelType
    
    var viewModel : ViewModelType! { get set }
    //바인딩에 필요한 메소드
    func bindViewModel()
}

extension ViewModelBindableType where Self : UIViewController {
    //VC에 추가된 viewModel속성에 파라미터로 보내진 실제 viewModel 저장
    //bindViewModel 호출
    //결과 : vc에서 bind함수 직접 호출할 필요 없어 코드 단순
    mutating func bind(viewModel : Self.ViewModelType) {
        self.viewModel = viewModel
        loadViewIfNeeded()
        
        bindViewModel()
    }
}
