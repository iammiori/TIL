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
import RxDataSources

//MARK: SectionModel (rxdatasource 쓰기위해)

typealias RecordSctionModel = AnimatableSectionModel<Int, Record>

class RecordListViewModel : CommonViewModel {
    // 테이블뷰와 바인딩 할 수 있는 속성
//    var recordList : Observable<[Record]> {
//        return storage.readRecord()
//    }
    var recordList : Observable<[RecordSctionModel]> {
        return storage.readRecord()
    }
    
    //MARK: Rx - 테이블뷰 바인딩에 사용한 데이터 소스 속성
    let datasoruce : RxTableViewSectionedAnimatedDataSource<RecordSctionModel> = {
        let ds = RxTableViewSectionedAnimatedDataSource<RecordSctionModel> { dataSource, tableView, indexPath, record in
            guard let cell = tableView.dequeueReusableCell(withIdentifier: RecordListTableViewCell.registerID, for: indexPath) as? RecordListTableViewCell else { return UITableViewCell() }
            //let cell = tableView.dequeueReusableCell(withIdentifier: RecordListTableViewCell.registerID, for: indexPath)
            cell.mainLabel.text = record.record
            //cell.textLabel?.text = record.record
            return cell
        }
        ds.canEditRowAtIndexPath = { _, _ in return true }
        return ds
    }()
    

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
    
    //MARK: 속성형태로
    //입력형식 : Record 출력형식 : Void
    //클로저 내부에서 self로 접근해야하므로 lazy
    lazy var detailAction : Action<Record, Void> = {
        
        return Action { record in
            let detailViewModel = DetailRecordViewModel(record: record, title: "기록 보기", sceneCoordinator: self.sceneCoordinator, storage: self.storage)
            
            let detailScene = Scene.detail(detailViewModel)
            
            return self.sceneCoordinator.transition(to: detailScene, using: .push, animated: true)
                .asObservable()
                .map { _ in }
        }
    }()
    
    lazy var deleteAction : Action<Record, Void> =  {
        return Action { record in
            return self.storage.deleteRecord(record: record)
                .map { _ in }
        }
    }()
    
}
