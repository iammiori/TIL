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
        self.dismissKeyboardWhenTapBackGround()
        myTF.becomeFirstResponder()
        
        //MARK:  rx
        // 드라이버는 시퀀스를 공유 share 필요없음
        let result = myTF.rx.text.asDriver()
            .map { self.checkEmail(email: $0)}
            .asDriver(onErrorJustReturn: false)
        
        result
            .map { $0 ? "옳은 이메일 형식입니다 😀" : "이메일 형식이 아닙니다 ☹️"}
            .drive(myLabel.rx.text)
            //.bind(to: myLabel.rx.text)
            .disposed(by: disposeBag)
        
        result
            .map { $0 ? UIColor.systemGreen : UIColor.systemRed}
            .drive(myLabel.rx.textColor)
            //.bind(to: myLabel.rx.textColor)
            .disposed(by: disposeBag)
        
        myTF.rx.beginEditing
            .map { ColorWidth(color: .systemCyan, width: 2.0) }
            .bind(to: myTF.rx.borderColorWidth)
            .disposed(by: disposeBag)
        
        myTF.rx.endEditing
            .map { ColorWidth(color: .systemGray, width: 0.5) }
            .bind(to: myTF.rx.borderColorWidth)
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
        myTF.layer.borderWidth = 0.5
        myTF.layer.cornerRadius = 8
        
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

extension Reactive where Base : UITextField {
    var beginEditing : ControlEvent<Void> {
        return controlEvent(.editingDidBegin)
    }
    var endEditing : ControlEvent<Void> {
        return controlEvent(.editingDidEnd)
    }
    var borderColorWidth : Binder<ColorWidth?> {
//        return Binder(self.base) { textfield, colorWidth in
//            textfield.layer.borderColor = colorWidth?.color.cgColor
//            textfield.layer.borderWidth = CGFloat( colorWidth?.width ?? 0.5)
//        }
        //단축인자
        return Binder(self.base) {
            $0.layer.borderColor = $1?.color.cgColor
            $0.layer.borderWidth = CGFloat($1?.width ?? 0.5)
        }
        
    }
}
