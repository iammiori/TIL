//
//  Record.swift
//  RecordWOD
//
//  Created by miori Lee on 2022/03/14.
//

import Foundation
import RxDataSources
import CoreData
import RxCoreData

//RxDataSources 사용위해 IdentifiableType 추가
struct Record : Equatable, IdentifiableType {
    var record : String
    var recordDate : Date
    var identity : String
    // String은 Hashable 프로토콜을 채용한 형식
    init(record : String, recordDate : Date = Date()) {
        self.record = record
        self.recordDate = recordDate
        self.identity = "\(recordDate.timeIntervalSinceReferenceDate)"
    }
    
    //MARK: 업데이트 된 내용으로 새로운 Record 인스턴스 만들때
    init(pastData : Record, newRecord : String) {
        self = pastData
        self.record = newRecord
    }
}

extension Record : Persistable {
    //entityName 반환
    static var entityName: String {
        return "Record"
    }
    // id필드
    static var primaryAttributeName: String {
        return "identity"
    }
    
    init(entity : NSManagedObject) {
        record = entity.value(forKey: "content") as! String
        recordDate = entity.value(forKey: "insertDate") as! Date
        identity = "\(recordDate.timeIntervalSinceReferenceDate)"
    }
    
    func update(_ entity: NSManagedObject) {
        entity.setValue(record, forKey: "content")
        entity.setValue(recordDate, forKey: "insertDate")
        entity.setValue("\(recordDate.timeIntervalSinceReferenceDate)", forKey: "identity")
        
        //rxcoredate context 자동 저장
        //coredata 는 직접 구현해야함
        do {
            try entity.managedObjectContext?.save()
        } catch {
            print(error)
        }
    }
    
    
}
