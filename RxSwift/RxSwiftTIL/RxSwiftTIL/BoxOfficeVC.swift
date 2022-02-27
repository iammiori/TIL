//
//  BoxOfficeVC.swift
//  RxSwiftTIL
//
//  Created by miori Lee on 2022/02/27.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class BoxOfficeVC : UIViewController {
    
    let disposeBag = DisposeBag()
    let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        attribute()
        layout()
        
        //MARK: data -> cell에 뿌리기
        BoxOfficeNetwork().getBoxOffice()
            //single -> Observable
            .asObservable()
            .share()
            // 성공 값 value 꺼내기
            .compactMap { data -> BoxOfficeResponse? in
                guard case let .success(value) = data
                else {
                    return nil
                }
                return value
            }
            // 꺼낸 response -> weeklyBoxOfficeList 변형
            .map { $0.boxOfficeResult.weeklyBoxOfficeList}
            // drive로 셀에 뿌리기
            .asDriver(onErrorJustReturn: [])
            .drive(tableView.rx.items(cellIdentifier: BoxOfficeTableViewCell.registerID, cellType: BoxOfficeTableViewCell.self)) { [weak self] row, element, cell in
                cell.setData(element)
            }
            .disposed(by: disposeBag)

        
//            .subscribe(onSuccess: { data in
//                print("성공 : \(data)")
//            }, onFailure: { error in
//                print("에러 : \(error)")
//            })
//            .disposed(by: disposeBag)

        
    }
}

extension BoxOfficeVC {
    private func attribute(){
        self.title = "Rx + URLSession"
        view.backgroundColor = .white
        
        tableView.register(BoxOfficeTableViewCell.self, forCellReuseIdentifier: BoxOfficeTableViewCell.registerID)
        
    }
    private func layout(){
        [tableView].forEach {self.view.addSubview($0)}
        
        tableView.snp.makeConstraints {
            $0.centerX.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(8)
            $0.top.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func bind(_ viewModel : BoxOfficeViewModel) {
        //MARK: MVVM 합체
        viewModel.detailListCellData
            .drive(tableView.rx.items(cellIdentifier: BoxOfficeTableViewCell.registerID, cellType: BoxOfficeTableViewCell.self)) { [weak self] row, element, cell in
                cell.setData(element)
            }
            .disposed(by: disposeBag)
    }
}
