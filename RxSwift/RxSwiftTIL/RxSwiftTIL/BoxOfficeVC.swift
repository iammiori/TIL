//
//  BoxOfficeVC.swift
//  RxSwiftTIL
//
//  Created by miori Lee on 2022/02/27.
//

import Foundation
import UIKit
import RxSwift

class BoxOfficeVC : UIViewController {
    
    let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        BoxOfficeNetwork().getBoxOffice()
            .subscribe(onSuccess: { data in
                print("성공 : \(data)")
            }, onFailure: { error in
                print("에러 : \(error)")
            })
            .disposed(by: disposeBag)


        
    }
}
