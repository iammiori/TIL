//
//  BoxOfficeBackGroundView.swift
//  RxSwiftTIL
//
//  Created by miori Lee on 2022/03/03.
//

import UIKit
import RxSwift
import RxCocoa

class BoxOfficeBackGroundView : UIView {
    let disposeBag = DisposeBag()
    let noticeEmptyLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        attribute()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind(_ viewModel : BoxOfficeBackGroundViewModel) {
        //뷰모델에서 가져온 isStatusLabelHidden값을 rx.isHidden과 연결
        viewModel.isNoticeEmptyLabelHidden
            .emit(to: noticeEmptyLabel.rx.isHidden)
            .disposed(by: disposeBag)
    }
    
    private func attribute(){
        backgroundColor = .white
        noticeEmptyLabel.text = "🛠\n아직 업데이트 되지 않았어요"
        noticeEmptyLabel.textAlignment = .center
        noticeEmptyLabel.numberOfLines = 0
    }
    
    private func layout(){
        addSubview(noticeEmptyLabel)
        noticeEmptyLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(20)
        }
    }
}

