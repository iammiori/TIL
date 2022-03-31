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
