//
//  CustomCell.swift
//  RxDataSource_Test
//
//  Created by Takafumi Ogaito on 2019/01/25.
//  Copyright © 2019 test. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class CustomCell: UITableViewCell {
    
    var disposeBag =  DisposeBag()

    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var rightButton: UIButton!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
