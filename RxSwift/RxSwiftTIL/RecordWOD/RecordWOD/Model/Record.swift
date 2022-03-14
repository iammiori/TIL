//
//  Record.swift
//  RecordWOD
//
//  Created by miori Lee on 2022/03/14.
//

import Foundation

struct Record : Equatable {
    var record : String
    var recordDate : Date
    var identity : String
    
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
