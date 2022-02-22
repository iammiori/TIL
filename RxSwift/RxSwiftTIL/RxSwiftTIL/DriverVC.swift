//
//  DriverVC.swift
//  RxSwiftTIL
//
//  Created by miori Lee on 2022/02/22.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class DriverVC : UIViewController {
    
    let myLabel = UILabel()
    let myTF = UITextField()
    
    let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        attribute()
        layout()
        
        //MARK: Delegate 활용
        //myTF.delegate = self
        
        myTF.becomeFirstResponder()
        
        //MARK:  rx
        // 드라이버는 시퀀스를 공유 share 필요없음
        let result = myTF.rx.text //.asDriver()
            .map { self.checkEmail(email: $0)}
            //.asDriver(onErrorJustReturn: false)
        
        result
            .map { $0 ? "옳은 이메일 형식입니다 😀" : "이메일 형식이 아닙니다 ☹️"}
            //.drive(myLabel.rx.text)
            .bind(to: myLabel.rx.text)
            .disposed(by: disposeBag)
        
        result
            .map { $0 ? UIColor.systemGreen : UIColor.systemRed}
            .bind(to: myLabel.rx.textColor)
            .disposed(by: disposeBag)
    }
}

extension DriverVC {
    private func attribute(){
        self.title = "Driver 연습"
        view.backgroundColor = .white
        myLabel.textAlignment = .center
        myTF.placeholder = "입력해주세요"
        myTF.borderStyle = .roundedRect
        myTF.keyboardType = .emailAddress
        myTF.autocapitalizationType = .none
        
    }
    private func layout(){
        [myLabel,myTF].forEach { view.addSubview($0) }
        
        myTF.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(15)
            $0.centerX.equalToSuperview()
            $0.leadingMargin.equalTo(10)
        }
        
        myLabel.snp.makeConstraints {
            $0.top.equalTo(myTF.snp.bottom).offset(30)
            $0.leading.trailing.equalTo(myTF)
        }
    }
    
    private func checkEmail(email : String?) -> Bool {
        guard let email = email else {
            return false
        }
        print("start:\(email)")
        defer {
            print("finish:\(email)")
        }
        return email.contains("@")
    }
}
