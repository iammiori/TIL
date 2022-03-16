//
//  MemoryStorage.swift
//  RecordWOD
//
//  Created by miori Lee on 2022/03/17.
//

import Foundation
import RxSwift

class MemoryStorage : RecordStorageType {
    
    // list는 외부에서 접근할 필요없음 ( pirvate 선언)
    // 배열은 observable 통해서 외부로 공개
    // list 변경 되었을 때, Observable은  next event 방출해야함
    
    private var list = [
        Record(record: "Front Squat 115lb", recordDate: Date().addingTimeInterval(-10)),
        Record(record: "Snatch 75lb", recordDate: Date().addingTimeInterval(-20))
    ]
    
    // 초기 dummy data 보여줄거라서 behavior
    private lazy var store = BehaviorSubject<[Record]>(value: list)
    
    @discardableResult
    func createRecord(record: String) -> Observable<Record> {
        let record = Record(record: record)
        list.insert(record, at: 0)
        //subject에서 next 방출
        store.onNext(list)
        return Observable.just(record)
    }
    
    //MARK: 이 매소드 통해 subject 접근
    @discardableResult
    func readRecord() -> Observable<[Record]> {
        return store
    }
    
    @discardableResult
    func updateRecord(record: Record, newRecord: String) -> Observable<Record> {
        let updated = Record(pastData: record, newRecord: newRecord)
        if let index = list.firstIndex(where: { $0 == record }) {
            list.remove(at: index)
            list.insert(updated, at: index)
        }
        
        store.onNext(list)
        return Observable.just(updated)
    }
    
    @discardableResult
    func deleteRecord(record: Record) -> Observable<Record> {
        //list에서 삭제후, subject에서 next 방출
        if let index = list.firstIndex(where: { $0 == record}) {
            list.remove(at: index)
        }
        store.onNext(list)
        return Observable.just(record)
    }
}

//MARK: next 방출의 의의
/*
 - 내부 배열 변경후, subject에서 next 방출
 - reloadData 없기 때문에, -> 새로운 배열 계속 방출해야함 (그래야 update됨)
 */
