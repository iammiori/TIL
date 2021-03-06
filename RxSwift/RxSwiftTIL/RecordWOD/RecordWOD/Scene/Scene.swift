//
//  Scene.swift
//  RecordWOD
//
//  Created by miori Lee on 2022/03/21.
//

import UIKit

//MARK: 앱에서 구현할 씬 enum
enum Scene {
    //연관된 뷰모델을 연관값으로 저장
    case list(RecordListViewModel)
    case detail(DetailRecordViewModel)
    case edit(EditRecordViewModel)
    case share(String)
}

extension Scene {
    //MARK: scene 생성후, 연관값에 저장된 뷰 모델 바인딩 해서 리턴
    func instantiate(from vc : UIViewController = RecordListViewController()) -> UIViewController {
        switch self {
        case .list(let recordListViewModel):
            //record 목록 scene 생성 후, 뷰 모델 바인딩
            let nav = UINavigationController()
            let mainView = RecordListViewController()
            nav.viewControllers = [mainView]
            guard var listVC = nav.viewControllers.first as? RecordListViewController else {
                fatalError()
            }
            //tableview LargeTitle error 수정
            DispatchQueue.main.async {
                listVC.bind(viewModel: recordListViewModel)
            }
            
            return nav
        case .detail(let detailRecordViewModel):
            var detailVC = DetailRecordViewController()
            //tableview LargeTitle error 수정
            DispatchQueue.main.async {
                detailVC.bind(viewModel: detailRecordViewModel)
            }
            
            return detailVC
        case .edit(let editRecordViewModel):
            let nav = UINavigationController()
            let editView = EditRecordViewController()
            nav.viewControllers = [editView]
            guard var editVC = nav.viewControllers.first as? EditRecordViewController else {
                fatalError()
            }
            DispatchQueue.main.async {
                editVC.bind(viewModel: editRecordViewModel)
            }
            
            return nav
            
        case .share(let record) :
            let shareVC = UIActivityViewController(activityItems: [record], applicationActivities: nil)
            return shareVC
        }
        
    }
}
