//
//  DetailRecordViewController.swift
//  RecordWOD
//
//  Created by miori Lee on 2022/03/17.
//

import UIKit

class DetailRecordViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        attribute()
        layout()
        // Do any additional setup after loading the view.
    }

}

extension DetailRecordViewController {
    private func attribute() {
        self.navigationItem.largeTitleDisplayMode = .never
        self.title = "메모보기"
        self.view.backgroundColor = .white
    }
    
    private func layout() {

    }
    

}
