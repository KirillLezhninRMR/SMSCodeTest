//
//  ViewController.swift
//  SmsCodeTest
//
//  Created by Кирилл Лежнин on 25.06.2021.
//

import UIKit

class ViewController: UIViewController {
    var inputedCode = "" {
        didSet {
            lblCode.text = inputedCode
        }
    }
    @IBOutlet var txtFieldOneTimeCode: MyTextField!
    @IBOutlet var lblCode: UILabel!
    private let notDigits = CharacterSet(charactersIn: "0123456789٠١٢٣٤٥٦٧٨٩").inverted

    override func viewDidLoad() {
        super.viewDidLoad()
        txtFieldOneTimeCode.delegate = self
        txtFieldOneTimeCode.addTarget(self,
                                      action: #selector(textFieldDidChange),
                                      for: .allEditingEvents)

        txtFieldOneTimeCode.backspaceCalled = {
            if !self.inputedCode.isEmpty {
                self.inputedCode.removeLast()
            }
            self.lblCode.text = self.inputedCode.isEmpty ? "Code" : self.inputedCode
        }

        NotificationCenter.default.addObserver(self, selector: #selector(didBecomeActive), name: UIApplication.didBecomeActiveNotification, object: nil)


        txtFieldOneTimeCode.becomeFirstResponder()
    }

    @objc func didBecomeActive() {
        txtFieldOneTimeCode.becomeFirstResponder()
    }

    @objc func textFieldDidChange() {
        txtFieldOneTimeCode.text?.removeAll()
    }

}

extension ViewController: UITextFieldDelegate {

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        txtFieldOneTimeCode.text?.removeAll()
        var newText: String
        print("String is \(string)")
        if string == "" && range.length == 0 {
            // In case one time code is pasted from messages
            inputedCode = ""
            return true
        } else {
            newText = string
        }

        if inputedCode.count == 4 {
            return false
        }

        if newText.rangeOfCharacter(from: notDigits) != nil {
            return false
        }

        print(newText)
        inputedCode.append(newText)
        txtFieldOneTimeCode.text?.removeAll()
        return true
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        txtFieldOneTimeCode.text?.removeAll()
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        txtFieldOneTimeCode.text?.removeAll()
    }
}

