//
//  RecordListTableViewCell.swift
//  RecordWOD
//
//  Created by miori Lee on 2022/03/18.
//

import UIKit

class RecordListTableViewCell: UITableViewCell {

    static let registerID = "\(RecordListTableViewCell.self)"
    
    let mainLabel = UILabel()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override init(style : UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func attribute() {
        self.accessoryType = .disclosureIndicator
        mainLabel.font = .systemFont(ofSize: 12)
    }
    
    private func layout() {
        [mainLabel].forEach {contentView.addSubview($0)}
        
        mainLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(12)
            $0.leading.equalToSuperview().offset(10)
            $0.bottom.equalToSuperview().inset(12)
        }
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
