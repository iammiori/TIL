//
//  DetailRecordViewController.swift
//  RecordWOD
//
//  Created by miori Lee on 2022/03/17.
//

import UIKit
import RxSwift

class DetailRecordViewController: UIViewController, ViewModelBindableType {
    
    lazy var toolBar = UIToolbar()
    var toolBarTrashBtn = UIButton()
    var toolBarWirteBtn = UIButton()
    var toolBarActionBtn = UIButton()
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
        //MARK: subject 가 다시 방출하도록 수정 해야 데이터도 수정
        
        toolBarWirteBtn.rx.action = viewModel.makeEditAction()
//        toolBarActionBtn.rx.action =
        
//        toolBarActionBtn.rx.tap
//            .throttle(.microseconds(500), scheduler: MainScheduler.instance)
//            .withUnretained(self)
//            .subscribe(onNext: { (vc, _) in
//                let record = vc.viewModel.record.record
//
//                let shareVC = UIActivityViewController(activityItems: [record], applicationActivities: nil)
//                vc.present(shareVC, animated: true, completion: nil)
//            })
//            .disposed(by: disposeBag)
        
        toolBarActionBtn.rx.action = viewModel.openShareAction()

        toolBarTrashBtn.rx.action = viewModel.makeDeleteAction()
        
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
            //$0.leading.trailing.equalToSuperview()
            $0.width.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        tableView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(toolBar.snp.top)
        }
    }
    
    private func setToolBar() {
        toolBar = UIToolbar(frame: CGRect(origin: CGPoint.zero, size: CGSize(width: self.view.bounds.width, height: CGFloat(44))))
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
