//
//  ViewModel.swift
//  RxDataSource_Test
//
//  Created by Takafumi Ogaito on 2019/01/25.
//  Copyright © 2019 test. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

typealias SettingsSectionModel = SectionModel<SettingsSection,SettingsItem>

enum SettingsSection {
    case account
    case common
    case other
    
    var headerHeight: CGFloat {
        return 40.0
    }
    
    var footerHeight: CGFloat {
        return 1.0
    }
}

enum SettingsItem {
    // account section
    case account
    case security
    case notification
    case contents
    // common section
    case sounds
    case dataUsing
    case accessibility
    // other section
    case credits
    case version
    case privacyPolicy
    
    // other
    case description(text: String)
    
    var title: String? {
        switch self {
        case .account:
            return "アカウント"
        case .security:
            return "セキュリティ"
        case .notification:
            return "通知"
        case .contents:
            return "コンテンツ設定"
        case .sounds:
            return "サウンド設定"
        case .dataUsing:
            return "データ利用時の設定"
        case .accessibility:
            return "アクセシビリティ"
        case .description:
            return nil
        case .credits:
            return "クレジット"
        case .version:
            return "バージョン情報"
        case .privacyPolicy:
            return "プライバシーポリシー"
        }
    }
    
    var rowHeight: CGFloat {
        switch self {
        case .description:
            return 72.0
        default:
            return 48.0
        }
    }
    
    var accessoryType: UITableViewCell.AccessoryType {
        switch self {
        case .account,.security,.notification,.contents,
             .sounds,.dataUsing,.accessibility,
             .credits,.version,.privacyPolicy:
            return .disclosureIndicator
        case .description:
            return .none
        }
    }
}

class ViewModel {
    
    private let items = BehaviorRelay<[SettingsSectionModel]>(value: [])
    
    var itemsObservable: Observable<[SettingsSectionModel]> {
        return items.asObservable()
    }
    
    func setup() {
        updateItems()
    }
    
    private func updateItems() {
        let sections: [SettingsSectionModel] = [
            accountSection(),
            commonSection(),
            otherSection()
        ]
        items.accept(sections)
    }
    
    private func accountSection() -> SettingsSectionModel {
        let items: [SettingsItem] = [
            .account,
            .security,
            .notification,
            .contents
        ]
        return SettingsSectionModel(model: .account, items: items)
    }
    
    private func commonSection() -> SettingsSectionModel {
        let items: [SettingsItem] = [
            .sounds,
            .dataUsing,
            .accessibility,
            .description(text: "基本設定はこの端末でログインしている全てのアカウントに適用されます。")
        ]
        return SettingsSectionModel(model: .common, items: items)
    }
    
    private func otherSection() -> SettingsSectionModel {
        let items: [SettingsItem] = [
            .credits,
            .version,
            .privacyPolicy
        ]
        return SettingsSectionModel(model: .other, items: items)
    }
}
