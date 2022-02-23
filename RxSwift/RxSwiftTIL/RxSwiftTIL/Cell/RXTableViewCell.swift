//
//  RXTableViewCell.swift
//  RxSwiftTIL
//
//  Created by miori Lee on 2022/02/23.
//

import UIKit

class RXTableViewCell: UITableViewCell {

    static let registerID = "\(RXTableViewCell.self)"
    
    let categoryLabel = UILabel()
    let nameLabel = UILabel()
    let movementsLabel = UILabel()
    let levelLabel = UILabel()

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        attribue()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func attribue(){
        backgroundColor = .white
        
        categoryLabel.font = .systemFont(ofSize: 8)
        nameLabel.font = .systemFont(ofSize: 11, weight: .heavy)
        movementsLabel.font = .systemFont(ofSize: 9)
        levelLabel.font = .systemFont(ofSize: 9)
        
        categoryLabel.textColor = .gray
        
        movementsLabel.numberOfLines = 0
    }
    
    private func layout(){
        [categoryLabel,nameLabel,movementsLabel,levelLabel].forEach {
            contentView.addSubview($0)
        }

        categoryLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(10)
            $0.top.equalToSuperview().offset(8)
        }
        
        nameLabel.snp.makeConstraints {
            $0.leading.equalTo(categoryLabel)
            $0.top.equalTo(categoryLabel.snp.bottom).offset(4)
        }
        
        movementsLabel.snp.makeConstraints {
            $0.leading.equalTo(categoryLabel)
            $0.top.equalTo(nameLabel.snp.bottom).offset(4)
            $0.trailing.equalToSuperview().inset(10)
            $0.bottom.equalToSuperview().inset(8)
        }
        
        levelLabel.snp.makeConstraints {
            $0.bottom.equalTo(movementsLabel)
            $0.trailing.equalToSuperview().inset(10)
        }

    }

    func setData(_ dataEntity : CrossfitMovements) {
        categoryLabel.text = dataEntity.category.rawValue
        nameLabel.text = dataEntity.name
        movementsLabel.text = dataEntity.movements
        levelLabel.text = dataEntity.level
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

