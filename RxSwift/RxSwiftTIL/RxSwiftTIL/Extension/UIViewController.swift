//
//  UIViewController.swift
//  RxSwiftTIL
//
//  Created by miori Lee on 2022/02/23.
//

import UIKit
import RxSwift
import RxCocoa

extension UIViewController {
    // 하나의 액션을 표시하는 alert wrapping
    func showAlert(title : String, message: String? = nil) -> Observable<String> {
        //Observable<ActionType>
        return Observable.create { [weak self] observer in
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default) { _ in
                // event 전달
                observer.onNext(title)
                //observer.onNext(.ok)
                observer.onCompleted()
            }
            alertController.addAction(okAction)
            
            self?.present(alertController, animated: true, completion: nil)
            
            return Disposables.create {
                alertController.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    func showAlertWithCancel(title: String, message : String? = nil) -> Observable<ActionType> {
        
        return Observable.create { [weak self] observer in
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default) { _ in
                // event 전달
                observer.onNext(.ok)
                observer.onCompleted()
            }
            
            let cancelAtion = UIAlertAction(title: "CANCEL", style: .cancel) { _ in
                observer.onNext(.cancel)
                observer.onCompleted()
            }
            
            [okAction,cancelAtion].forEach { alertController.addAction($0)}
           
            
            self?.present(alertController, animated: true, completion: nil)
            
            return Disposables.create {
                alertController.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    // MARK:  빈 view 눌렀을때 키보드가 내려가!
    func dismissKeyboardWhenTapBackGround() {
        let tap: UITapGestureRecognizer =
            UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        self.view.addGestureRecognizer(tap)
    }
    
    @objc private func dismissKeyboard() {
        self.view.endEditing(false)
    }
}
