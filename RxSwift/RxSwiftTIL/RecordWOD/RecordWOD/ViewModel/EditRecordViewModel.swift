//
//  EditRecordViewModel.swift
//  RecordWOD
//
//  Created by miori Lee on 2022/03/17.
//

import Foundation
import RxSwift
import RxCocoa
import Action

class EditRecordViewModel : CommonViewModel {
    //기록을 저장하는 속성
    // 새로운 기록 : nil
    //  편집 : string
    private let content : String?
    // 뷰에 바인딩 할수 있도록 driver
    var initalText : Driver<String?> {
        return Observable.just(content).asDriver(onErrorJustReturn: nil)
    }
    
    let saveAction : Action<String, Void>
    let cancelAction : CocoaAction
    init(title : String, content : String? = nil, sceneCoordinator : SceneCoordinatorType, storage : RecordStorageType, saveAction : Action<String, Void>? = nil, cancelAction : CocoaAction? = nil) {
        self.content = content
        self.saveAction = Action<String,Void> { input in
            if let action = saveAction {
                action.execute(input)
            }
            return sceneCoordinator.close(animated: true).asObservable().map { _ in }
        }
        
        self.cancelAction = CocoaAction {
            if let action = cancelAction {
                action.execute(())
            }
            
            return sceneCoordinator.close(animated: true).asObservable().map { _ in }
        }
        
        super.init(title: title, sceneCoordinator: sceneCoordinator, storage: storage)
    }
}
