//
//  EditRecordViewController.swift
//  RecordWOD
//
//  Created by miori Lee on 2022/03/17.
//

import UIKit
import RxSwift
import RxCocoa
import Action

class EditRecordViewController: UIViewController, ViewModelBindableType {
    
    let textView = UITextView()
    var cancelBtn = UIButton()
    var saveBtn = UIButton()
    var viewModel: EditRecordViewModel!
    let disposeBag = DisposeBag()

    func bindViewModel() {
        viewModel.title
            .drive(navigationItem.rx.title)
            .disposed(by: disposeBag)
        
        viewModel.initalText
            .drive(textView.rx.text)
            .disposed(by: disposeBag)
        
        cancelBtn.rx.action = viewModel.cancelAction
        
        saveBtn.rx.tap
            .throttle(.milliseconds(500), scheduler: MainScheduler.instance)
            .withLatestFrom(textView.rx.text.orEmpty)
            .bind(to: viewModel.saveAction.inputs)
            .disposed(by: disposeBag)
        
        //keyboard will show
        //notification메소드로 처리할 notification이름을 전달하면,
        //해당 notification이 전달되는 시점마다 next event를
        //방출하는 옵저버블을 리턴
        //next event에는 notification 객체 저장되어있음
        let willSHowObservable = NotificationCenter.default.rx.notification(UIResponder.keyboardWillShowNotification)
        //옵셔널 자동 언랩핑하기위해 compactMap
            .compactMap { $0.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue }
            .map { $0.cgRectValue.height }
        
        //키보드가 사라질때는 추가한 여백 제거하면 되므로 0을 방출
        let willHideObservable = NotificationCenter.default.rx.notification(UIResponder.keyboardWillHideNotification)
            .map { noti -> CGFloat in 0 }
        
        let keyboardObservable = Observable.merge(willSHowObservable, willHideObservable)
            .share()
        
        keyboardObservable
            .withUnretained(textView)
            .subscribe(onNext: { tv, height in
                var inset = tv.contentInset
                inset.bottom = height
                tv.contentInset = inset
                //스크롤 인디케이터
                var scrollInset = tv.verticalScrollIndicatorInsets
                scrollInset.bottom = height
                tv.verticalScrollIndicatorInsets = scrollInset
            })
            .disposed(by: disposeBag)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        attribute()
        layout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        textView.becomeFirstResponder()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if textView.isFirstResponder {
            textView.resignFirstResponder()
        }
    }

}

extension EditRecordViewController {
    private func attribute() {
        self.navigationItem.largeTitleDisplayMode = .never
        self.title = "메모 수정"
        self.view.backgroundColor = .white
        [cancelBtn,saveBtn].forEach { $0.setTitleColor(.systemBlue, for: .normal)}
        cancelBtn.setTitle("Cancel", for: .normal)
        saveBtn.setTitle("Save", for: .normal)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: saveBtn)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: cancelBtn)
        
        textView.autocorrectionType = .no
        textView.autocapitalizationType = .none
    }
    
    private func layout() {
        [textView,cancelBtn,saveBtn].forEach { self.view.addSubview($0)}
        
        textView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
