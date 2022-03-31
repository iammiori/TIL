//
//  RecordListViewModel.swift
//  RecordWOD
//
//  Created by miori Lee on 2022/03/17.
//

import Foundation
import RxSwift
import RxCocoa
import Action

class RecordListViewModel : CommonViewModel {
    // 테이블뷰와 바인딩 할 수 있는 속성
    var recordList : Observable<[Record]> {
        return storage.readRecord()
    }
    
    // + 버튼 눌렀을 때 새메모 모달
    func makeCreateAction() -> CocoaAction {
        // 새 기록 방출하는 옵저버블
        return CocoaAction { _ in
            return self.storage.createRecord(record: "")
                .flatMap { record -> Observable<Void> in
                    let editViewModel = EditRecordViewModel(title: "새 기록", sceneCoordinator: self.sceneCoordinator, storage: self.storage, saveAction: self.performUpdate(record: record), cancelAction: self.performCancel(record: record))
                    
                    let editScene = Scene.edit(editViewModel)
                    
                    return self.sceneCoordinator.transition(to: editScene, using: .modal, animated: true)
                        .asObservable()
                        .map { _ in }
                }
        }
    }
    
    func performUpdate(record : Record) -> Action<String, Void> {
        return Action { input in
            return self.storage.updateRecord(record: record, newRecord: input)
                .map { _ in }
        }
    }
    
    func performCancel(record : Record) -> CocoaAction {
        return Action {
            return self.storage.deleteRecord(record: record).map { _ in }
        }
    }
}
