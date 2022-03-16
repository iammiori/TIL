//
//  RecordListViewController.swift
//  RecordWOD
//
//  Created by miori Lee on 2022/03/17.
//

import Foundation
import UIKit
import SnapKit

class RecordListViewController : UIViewController {
    
    let btn = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        attribute()
        layout()
        
        btn.addTarget(self, action: #selector(goNext), for: .touchUpInside)
    }
}

extension RecordListViewController {
    private func attribute() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.title = "운동 기록 🏋🏻‍♀️"
        self.view.backgroundColor = .white
        btn.setTitleColor(.systemBlue, for: .normal)
        btn.setTitle("넘어갓", for: .normal)
    }
    
    private func layout() {
        [btn].forEach { self.view.addSubview($0)}
        
        btn.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
    }
    
    @objc func goNext() {
        self.navigationController?.pushViewController(DetailRecordViewController(), animated: false)
    }
}
