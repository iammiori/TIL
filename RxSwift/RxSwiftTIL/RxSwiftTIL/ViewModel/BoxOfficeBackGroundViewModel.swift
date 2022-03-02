//
//  BoxOfficeBackGroundViewModel.swift
//  RxSwiftTIL
//
//  Created by miori Lee on 2022/03/03.
//

import RxSwift
import RxCocoa

struct BoxOfficeBackGroundViewModel {
    //list에 데이터가 없으면 보여지고 있으면 숨겨지고
    //viewModel -> view
    let isStatusLabelHidden : Signal<Bool>
    
    // 외부에서 전달받을 값
    let shouldHideStatusLabel = PublishSubject<Bool>()
    
    init() {
        isStatusLabelHidden = shouldHideStatusLabel
            .asSignal(onErrorJustReturn: true)
    }
}

