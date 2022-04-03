//
//  DetailRecordViewModel.swift
//  RecordWOD
//
//  Created by miori Lee on 2022/03/17.
//

import Foundation
import Action
import RxSwift
import RxCocoa

class DetailRecordViewModel : CommonViewModel {
    
    //이전 scene에서 전달된 record 저장
    let record : Record
    
    private var formatter : DateFormatter = {
        let f = DateFormatter()
        f.locale = Locale(identifier: "ko_kr")
        f.dateStyle = .medium
        f.timeStyle = .medium
        return f
    }()
    
    //테이블 뷰에 record 표시
    //왜 behaviorSubject ? -> 편집 하고 메모 보기로 돌아왔을 때 편집 반영시키기 위해 (새로운 문자열 배열 방출) (옵저버블은 불가능)
    var contents : BehaviorSubject<[String]>
    
    init(record : Record, title: String, sceneCoordinator : SceneCoordinatorType, storage : RecordStorageType) {
        self.record = record
        
        contents = BehaviorSubject<[String]>(value: [record.record, formatter.string(from: record.recordDate)])
        super.init(title: title, sceneCoordinator: sceneCoordinator, storage: storage)
    }
    
    lazy var popActioin = CocoaAction { [unowned self] in
        return self.sceneCoordinator.close(animated: true)
            .asObservable()
            .map { _ in }
    }
}
