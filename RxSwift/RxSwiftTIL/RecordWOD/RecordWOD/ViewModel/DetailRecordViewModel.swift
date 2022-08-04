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
//    let record : Record
    var record: Record
    let disposeBag = DisposeBag()
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
    
    //MARK: 편집내용 업데이트 위해 메모 속성 업데이트 필요
    /*
     - 1. let memo -> var memo
     */
    func performUpdate(record : Record) -> Action<String, Void> {
        return Action { input in
            self.storage.updateRecord(record: record, newRecord: input)
            //새롭게 방출된 record를 record속성에 저장
                .do(onNext: { self.record = $0 })
                .map { [$0.record, self.formatter.string(from: $0.recordDate)]}
                .bind(onNext: {self.contents.onNext($0)})
                .disposed(by: self.disposeBag)
            return Observable.empty()
        }
    }
    
    func makeEditAction() -> CocoaAction {
        return CocoaAction { _ in
            let editViewModel = EditRecordViewModel(title: "기록 편집", content: self.record.record, sceneCoordinator: self.sceneCoordinator, storage: self.storage, saveAction: self.performUpdate(record: self.record))
            
            let eidtScene = Scene.edit(editViewModel)
            
            return self.sceneCoordinator.transition(to: eidtScene, using: .modal, animated: true)
                .asObservable()
                .map { _ in }
        }
    }
    
    func openShareAction() -> CocoaAction {
        return CocoaAction { _ in
            let shareVC = Scene.share(self.record.record)
            return self.sceneCoordinator.transition(to: shareVC, using: .modal, animated: true)
                .asObservable()
//                .throttle(.microseconds(500), scheduler: MainScheduler.instance)
                .map { _ in }
        }
    }
    
    func makeDeleteAction() -> CocoaAction {
        return Action { input in
            self.storage.deleteRecord(record: self.record)
            
            return self.sceneCoordinator.close(animated: true)
                .asObservable()
                .map { _ in }
        }
    }

}
