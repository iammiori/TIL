//
//  RXTableViewVC.swift
//  RxSwiftTIL
//
//  Created by miori Lee on 2022/02/23.
//

import Foundation
import UIKit
import SnapKit
import RxSwift
import RxCocoa

class RXTableViewVC : UIViewController {
    
    let tableView = UITableView()
    let filterBtn = UIButton()
    let disposeBag = DisposeBag()
    
    let allObservable = Observable.of(CrossfitWods)
    override func viewDidLoad() {
        super.viewDidLoad()
        
        attribute()
        layout()
        
        // 클로저로 전달되는 파라미터 row, element, cell
        // 파라미터로 전달되는 cell은 RXTableViewCell.self로 타입캐스팅 되서 전달됨
        allObservable.bind(to: tableView.rx.items(cellIdentifier: RXTableViewCell.registerID, cellType: RXTableViewCell.self)) { [weak self] row, element, cell in
            // 셀 구성
            cell.setData(element)
        }
        .disposed(by: disposeBag)
        
        //        // a
        //        tableView.rx.modelSelected(CrossfitMovements.self)
        //            .bind { wods in
        //                print(wods.name)
        //            }
        //            .disposed(by: disposeBag)
        //
        //        // b
        //        tableView.rx.itemSelected
        //            .bind { [weak self] indexPath in
        //                self?.tableView.deselectRow(at: indexPath, animated: false)
        //            }
        //            .disposed(by: disposeBag)
        
        // a b zip 가능 (control event)
        Observable.zip (tableView.rx.modelSelected(CrossfitMovements.self), tableView.rx.itemSelected)
            .bind { [weak self] (wods,indexPath) in
                self?.tableView.deselectRow(at: indexPath, animated: false)
                print(wods.name)
            }
            .disposed(by: disposeBag)
        
        tableView.rx.modelSelected(CrossfitMovements.self)
            .flatMap { [unowned self] wods in
                self.showAlert(title: wods.name, message: wods.movements)
            }
            .subscribe(onNext : { actionType in
                switch actionType {
                case .ok :
                    print("ok")
                default :
                    break
                }
            })
    }
}

extension RXTableViewVC {
    private func attribute(){
        self.title = "tableview에 rx연습"
        //self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: filterBtn)
        view.backgroundColor = .white
        
        //filterBtn.setImage(UIImage(systemName: "list.bullet"), for: .normal )
        
        // cell register
        tableView.register(RXTableViewCell.self, forCellReuseIdentifier: RXTableViewCell.registerID)
        
    }
    private func layout(){
        [tableView].forEach {self.view.addSubview($0)}
        
        tableView.snp.makeConstraints {
            $0.centerX.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(8)
            $0.top.equalTo(view.safeAreaLayoutGuide)
        }
    }
}
