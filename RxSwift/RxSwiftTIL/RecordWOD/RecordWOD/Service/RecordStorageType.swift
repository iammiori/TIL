//
//  RecordStorageType.swift
//  RecordWOD
//
//  Created by miori Lee on 2022/03/17.
//

import Foundation
import RxSwift

protocol RecordStorageType {
    //MARK: CRUD
    @discardableResult
    func createRecord(record : String) -> Observable<Record>
    
    @discardableResult
    //func readRecord() -> Observable<[Record]>
    func readRecord() -> Observable<[RecordSctionModel]>
    
    @discardableResult
    func updateRecord(record : Record, newRecord : String) -> Observable<Record>
    
    @discardableResult
    func deleteRecord(record : Record) -> Observable<Record>
}
