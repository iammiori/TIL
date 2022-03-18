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
    
    var viewModel: RecordListViewModel!
    
    func bindViewModel() {
        
    }
    

    let tableView = UITableView()
    
    let disposeBag = DisposeBag()
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
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: nil)
        tableView.register(RecordListTableViewCell.self, forCellReuseIdentifier: RecordListTableViewCell.registerID)
    }
    
    private func layout() {
        self.view.addSubview(tableView)
        
        tableView.snp.makeConstraints {
            $0.centerX.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(8)
            $0.top.equalTo(view.safeAreaLayoutGuide)
        }
    }
}
