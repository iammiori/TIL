//
//  DetailRecordDateCell.swift
//  RecordWOD
//
//  Created by miori Lee on 2022/04/01.
//

import UIKit

class DetailRecordDateCell: UITableViewCell {

    static let registerID = "\(DetailRecordDateCell.self)"
    
    let dateLabel = UILabel()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override init(style : UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        attribute()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func attribute() {
        dateLabel.font = .systemFont(ofSize: 10)
        dateLabel.textColor = .secondaryLabel
        dateLabel.textAlignment = .center
    }
    
    private func layout() {
        [dateLabel].forEach {contentView.addSubview($0)}
        
        dateLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(12)
            $0.bottom.equalToSuperview().inset(12)
            $0.centerX.equalToSuperview()
        }
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

