//
//  MyTextField.swift
//  SmsCodeTest
//
//  Created by Кирилл Лежнин on 27.06.2021.
//

import UIKit

final class MyTextField: UITextField {
    var backspaceCalled: (() -> Void)?
    override func deleteBackward() {
        super.deleteBackward()

        backspaceCalled?()
    }

    
}
