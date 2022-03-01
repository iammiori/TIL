//
//  BoxOfficeViewModel.swift
//  RxSwiftTIL
//
//  Created by miori Lee on 2022/02/28.
//

import Foundation
import RxCocoa
import RxSwift

struct BoxOfficeViewModel {
    let disposeBag = DisposeBag()
    // 셀에 뿌릴값
    let detailListCellData : Driver<[BoxOfficeList]>
    // 받아온값
    let apiData = PublishSubject<[BoxOfficeList]>()
    let filterBtnTapped = PublishRelay<Void>()
    
    init(_ networkModel : BoxOfficeNetwork = BoxOfficeNetwork()) {
        
        //네트워크값 observable로
        let boxOfficeResult = networkModel.getBoxOffice()
            .asObservable()
            .share()
        
        // success일때 value 꺼내고 nil 제거
        let boxOfficeResultValue = boxOfficeResult
            .compactMap { data -> BoxOfficeResponse? in
                guard case let .success(value) = data
                else {
                    return nil
                }
                return value
            }
        
        // respose 형태 중 weeklyBoxOfficeList로 map
        let cellData = boxOfficeResultValue
            .map { $0.boxOfficeResult.weeklyBoxOfficeList }
        
        cellData
            .bind(to: apiData)
            .disposed(by: disposeBag)

        self.detailListCellData = apiData
            .asDriver(onErrorJustReturn: [])
    }
}

