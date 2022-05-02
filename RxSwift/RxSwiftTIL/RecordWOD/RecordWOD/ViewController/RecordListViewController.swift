//
//  RecordListViewController.swift
//  RecordWOD
//
//  Created by miori Lee on 2022/03/17.
//

import Foundation
import UIKit
import SnapKit
import RxSwift
import RxCocoa

class RecordListViewController : UIViewController , ViewModelBindableType {
    
    let disposeBag = DisposeBag()
    var viewModel: RecordListViewModel!
    
    func bindViewModel() {
        viewModel.title
            .drive(navigationItem.rx.title)
            .disposed(by: disposeBag)
        
//        viewModel.recordList
//            .bind(to: tableView.rx.items(cellIdentifier: RecordListTableViewCell.registerID, cellType: RecordListTableViewCell.self)) { [weak self] row, element, cell in
//                cell.setData(element)
//            }
//            .disposed(by: disposeBag)
        
    
        viewModel.recordList
            .bind(to : tableView.rx.items(dataSource: viewModel.datasoruce))
            .disposed(by: disposeBag)
        //두개 이상의 섹션, 편집기능 구현해야한다면 rxdatasource or cocoatouch
        
        addBtn.rx.action = viewModel.makeCreateAction()
        
        //선택 이벤트
        // itemSelected -> 인덱스. 내용 -> model
        /*
         - rxswift5 : 클로저에서 vc 접근할때  [unowned self] 클로저 캡처리스트필요
         - rxswift6 : 다르게 구현 가능
         */
        Observable.zip(tableView.rx.modelSelected(Record.self), tableView.rx.itemSelected)
        //rxswift5
//            .do(onNext: { [unowned self] (_, indexPath) in
//                self.tableView.deselectRow(at: indexPath, animated: true)
//            })
        //rxswift6
        //withUnretained연산자 추가후 파라미터로 self 전달, self에 대한 비소유 참조와 zip 연산자가 방출하는 요소가 다시 하나의 튜플로 합쳐져서 방출 -> 클로저캡처리스트 삭제 가능
        // 튜플의 요소는 (self, indexpath) - > (vc, zip연산자가 방출한 data)
            .withUnretained(self)
            .do(onNext: { (vc, data) in
                vc.tableView.deselectRow(at: data.1, animated: true)
            })
                .map { $1.0 } //인덱스 이제 필요없으니까 선택한 메모로만 변경
                .bind(to: viewModel.detailAction.inputs)
                .disposed(by: disposeBag)
        
        tableView.rx.modelDeleted(Record.self)
            .throttle(.microseconds(500), scheduler: MainScheduler.instance)
            .bind(to: viewModel.deleteAction.inputs)
            .disposed(by: disposeBag)
    
    }
    

    let tableView = UITableView()
    var addBtn = UIButton()
    override func viewDidLoad() {
        super.viewDidLoad()
        attribute()
        layout()
        
//        btn.rx.tap
//            .bind {
//            self.navigationController?.pushViewController(DetailRecordViewController(), animated: false)
//            }
//            .disposed(by: disposeBag )
        
    }
    
}

extension RecordListViewController {
    private func attribute() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.title = "운동 기록 🏋🏻‍♀️"
        self.view.backgroundColor = .white
        addBtn.setImage(UIImage(systemName: "plus"), for: .normal)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: addBtn)
        tableView.register(RecordListTableViewCell.self, forCellReuseIdentifier: RecordListTableViewCell.registerID)
    }
    
    private func layout() {
        self.view.addSubview(tableView)
        [tableView,addBtn].forEach {  self.view.addSubview($0) }
        tableView.snp.makeConstraints {
            $0.centerX.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(8)
            $0.top.equalTo(view.safeAreaLayoutGuide)
        }
    }
}
