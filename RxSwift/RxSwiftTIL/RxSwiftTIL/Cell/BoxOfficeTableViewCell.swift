//
//  BoxOfficeTableViewCell.swift
//  RxSwiftTIL
//
//  Created by miori Lee on 2022/02/28.
//

import UIKit

class BoxOfficeTableViewCell : UITableViewCell {
    
    static let registerID = "\(BoxOfficeTableViewCell.self)"
    
    let movieNameLabel = UILabel()
    let oldnewLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        attribute()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func attribute(){
        backgroundColor = .white
        
        movieNameLabel.font = .systemFont(ofSize: 12, weight : .heavy)
        movieNameLabel.numberOfLines = 0
        
        oldnewLabel.font = .systemFont(ofSize: 10, weight: .medium)
    }
    
    private func layout(){
        [movieNameLabel,oldnewLabel].forEach {contentView.addSubview($0)}
        
        movieNameLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(12)
            $0.leading.equalToSuperview().offset(10)
            $0.bottom.equalToSuperview().inset(12)
        }
        
        oldnewLabel.snp.makeConstraints {
            $0.centerY.equalTo(movieNameLabel)
            $0.trailing.equalToSuperview().inset(12)
        }
    }
    
    func setData(_ dataEntity : BoxOfficeList) {
        movieNameLabel.text = dataEntity.movieNm
        oldnewLabel.text = dataEntity.rankOldAndNew
        
        if dataEntity.rankOldAndNew == "NEW" {
            oldnewLabel.textColor = .orange
        }
    }
}
