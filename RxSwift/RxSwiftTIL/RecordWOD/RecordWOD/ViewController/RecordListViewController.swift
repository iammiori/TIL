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
        
        viewModel.recordList
            .bind(to: tableView.rx.items(cellIdentifier: RecordListTableViewCell.registerID, cellType: RecordListTableViewCell.self)) { [weak self] row, element, cell in
                cell.setData(element)
            }
            .disposed(by: disposeBag)
        
        addBtn.rx.action = viewModel.makeCreateAction()
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
