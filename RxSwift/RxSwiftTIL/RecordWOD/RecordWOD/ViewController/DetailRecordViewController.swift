//
//  DetailRecordViewController.swift
//  RecordWOD
//
//  Created by miori Lee on 2022/03/17.
//

import UIKit
import RxSwift

class DetailRecordViewController: UIViewController, ViewModelBindableType {
    
    let toolBar = UIToolbar()
    let toolBarTrashBtn = UIButton()
    let toolBarWirteBtn = UIButton()
    let toolBarActionBtn = UIButton()
    let tableView = UITableView()
    var viewModel: DetailRecordViewModel!
    let disposeBag = DisposeBag()
    let cell = UITableViewCell()
    func bindViewModel() {
        viewModel.title
            .drive(navigationItem.rx.title)
            .disposed(by: disposeBag)
        
        viewModel.contents
            .bind(to: tableView.rx.items) { tableView, row, value in
                switch row {
                case 0 :
                    //let cell = tableView.dequeueReusableCell(withIdentifier: RecordListTableViewCell.registerID)!
                    guard let cell = tableView.dequeueReusableCell(withIdentifier: RecordListTableViewCell.registerID) as? RecordListTableViewCell else {
                        return UITableViewCell()
                    }
                    cell.mainLabel.text = value
                    cell.accessoryType = .none
                    return cell
                case 1:
                    guard let cell = tableView.dequeueReusableCell(withIdentifier: DetailRecordDateCell.registerID) as? DetailRecordDateCell else {
                        return UITableViewCell()
                    }
                    //let cell = tableView.dequeueReusableCell(withIdentifier: DetailRecordDateCell.registerID)!
                    cell.dateLabel.text = value
                    return cell
                default:
                    fatalError()
                }
            }
            .disposed(by: disposeBag)
        
//        var backButton = UIBarButtonItem(title: nil, style: .done, target: nil, action: nil)
//        viewModel.title
//            .drive(backButton.rx.title)
//            .disposed(by: disposeBag)
//        
//        backButton.rx.action = viewModel.popActioin
//        //navigationItem.backBarButtonItem = backButton
//        navigationItem.hidesBackButton = true
//        navigationItem.leftBarButtonItem = backButton
    }
    
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
        
        setToolBar()
        tableView.register(RecordListTableViewCell.self, forCellReuseIdentifier: RecordListTableViewCell.registerID)
        tableView.register(DetailRecordDateCell.self, forCellReuseIdentifier: DetailRecordDateCell.registerID)
        tableView.allowsSelection = false
        tableView.separatorStyle = .none
    }
    
    private func layout() {
        [toolBar,tableView].forEach { self.view.addSubview($0) }
        toolBar.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        tableView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(toolBar.snp.top)
        }
    }
    
    private func setToolBar() {
        toolBarTrashBtn.tintColor = .red
        toolBarTrashBtn.setImage(UIImage(systemName: "trash"), for: .normal)
        toolBarWirteBtn.setImage(UIImage(systemName: "square.and.pencil"), for: .normal)
        toolBarActionBtn.setImage(UIImage(systemName: "square.and.arrow.up"), for: .normal)
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        var items : [UIBarButtonItem] = []
        [toolBarTrashBtn, toolBarWirteBtn, toolBarActionBtn].forEach {
            items.append(UIBarButtonItem(customView: $0))
        }
        [1,3].forEach { items.insert(flexibleSpace, at: $0)}
        toolBar.setItems(items, animated: false)
    }
}
