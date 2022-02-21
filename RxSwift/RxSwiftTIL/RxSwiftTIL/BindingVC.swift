//
//  BindingVC.swift
//  RxSwiftTIL
//
//  Created by miori Lee on 2022/02/21.
//

import UIKit
import SnapKit
// rx 사용 위해
import RxSwift
import RxCocoa

class BindingVC: UIViewController {

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
        myTF.rx.text
            .map { [weak self] email -> String in
                guard let text = email else { return "이메일 형식이 아닙니다 ☹️"}
                if self!.checkEmail(email: text){
                    return "옳은 이메일 형식입니다 😀"
                } else {
                    return "이메일 형식이 아닙니다 ☹️"
                }
            }
            .bind(to: myLabel.rx.text)
            .disposed(by: disposeBag)
    }


}

extension BindingVC {
    private func attribute(){
        self.title = "Binding 연습"
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
    
    private func checkEmail(email : String) -> Bool {
        return email.contains("@")
    }
}

//MARK: Delegate 활용
//extension BindingVC : UITextFieldDelegate {
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//
//        guard let current = textField.text else {
//            return true
//        }
//
//        let finishText = (current as NSString).replacingCharacters(in: range, with: string)
//        if checkEmail(email: finishText){
//            myLabel.text = "옳은 이메일 형식입니다 😀"
//        } else {
//            myLabel.text = "이메일 형식이 아닙니다 ☹️"
//        }
//        //myLabel.text = finishText
//
//        return true
//    }
//}
