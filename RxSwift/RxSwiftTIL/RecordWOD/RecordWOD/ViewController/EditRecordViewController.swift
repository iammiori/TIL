//
//  EditRecordViewController.swift
//  RecordWOD
//
//  Created by miori Lee on 2022/03/17.
//

import UIKit

class EditRecordViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        attribute()
        layout()
    }

}

extension EditRecordViewController {
    private func attribute() {
        self.navigationItem.largeTitleDisplayMode = .never
        self.title = "메모 수정"
        self.view.backgroundColor = .white
    }
    
    private func layout() {
        
    }
}
