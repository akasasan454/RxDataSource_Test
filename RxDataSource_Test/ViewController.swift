//
//  ViewController.swift
//  RxDataSource_Test
//
//  Created by Takafumi Ogaito on 2019/01/25.
//  Copyright © 2019 test. All rights reserved.
//

import UIKit
import RxSwift
import RxDataSources

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private var disposeBag = DisposeBag()
    
    private lazy var dataSource = RxTableViewSectionedReloadDataSource<SettingsSectionModel>(configureCell: configureCell)
    
    private lazy var configureCell:
        RxTableViewSectionedReloadDataSource<SettingsSectionModel>.ConfigureCell =
        { [weak self] (datasource, tableView, indexPath, _) in
            let item = datasource[indexPath]
            switch item {
            case .account, .security, .notification, .contents,
                 .sounds, .dataUsing, .accessibility,
                 .credits, .version, .privacyPolicy:
                let cell = tableView
                    .dequeueReusableCell(withIdentifier: "cell", for: indexPath)
                cell.textLabel?.text = item.title
                cell.accessoryType = item.accessoryType
                return cell
            case .description(let text):
            let cell = tableView
                .dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.textLabel?.text = text
            cell.isUserInteractionEnabled = false
            return cell
            }
        }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewController()
        setupTableView()
        setupViewModel()
    }
    
    private func setupViewController() {
        navigationItem.title = "設定"
    }
    
    private func setupTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.contentInset.bottom = 12.0
        tableView.rx.setDelegate(self).disposed(by: disposeBag)
        tableView.rx.itemSelected
            .subscribe(onNext: { [weak self] indexPath in
                guard let item = self?.dataSource[indexPath] else { return }
                self?.tableView.deselectRow(at: indexPath, animated: true)
                switch item {
                case .account:
                    // 遷移させる処理
                    // コンパイルエラー回避のためにbreakをかいていますが処理を書いていればbreakは必要ありません。
                    break
                case .security:
                    // 遷移させる処理
                    break
                case .notification:
                    // 遷移させる処理
                    break
                case .contents:
                    // 遷移させる処理
                    break
                case .sounds:
                    // 遷移させる処理
                    break
                case .dataUsing:
                    // 遷移させる処理
                    break
                case .accessibility:
                    // 遷移させる処理
                    break
                case .credits:
                    // 遷移させる処理
                    break
                case .version:
                    // 遷移させる処理
                    break
                case .privacyPolicy:
                    // 遷移させる処理
                    break
                case .description:
                    break
                }
            })
            .disposed(by: disposeBag)
    }
    
    private func setupViewModel() {
        let viewModel = ViewModel()
        
        viewModel.itemsObservable
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        viewModel.setup()
    }

}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView,
                   heightForRowAt indexPath: IndexPath) -> CGFloat {
        let item = dataSource[indexPath]
        return item.rowHeight
    }
    func tableView(_ tableView: UITableView,
                   heightForHeaderInSection section: Int) -> CGFloat {
        let section = dataSource[section]
        return section.model.headerHeight
    }
    
    func tableView(_ tableView: UITableView,
                   heightForFooterInSection section: Int) -> CGFloat {
        let section = dataSource[section]
        return section.model.footerHeight
    }
    
    func tableView(_ tableView: UITableView,
                   viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .clear
        return headerView
    }
    
    func tableView(_ tableView: UITableView,
                   viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView()
        footerView.backgroundColor = .clear
        return footerView
    }
}

