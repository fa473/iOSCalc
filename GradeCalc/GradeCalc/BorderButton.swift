//
//  BorderButton.swift
//  GradeCalc
//
//  Created by home on 12/11/17.
//  Copyright © 2017 home. All rights reserved.
//

import UIKit

class BorderButton: UIButton {

    override func awakeFromNib() {
        super.awakeFromNib()
        layer.borderColor = UIColor.white.cgColor
        layer.borderWidth = 1
    }

}
