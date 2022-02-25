//
//  UITextField+Rx.swift
//  RxSwiftTIL
//
//  Created by miori Lee on 2022/02/25.
//

import RxSwift
import RxCocoa
import UIKit


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
            $0.layer.borderWidth = $1?.width ?? 0.5
        }
        
    }
}

