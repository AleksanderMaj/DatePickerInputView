//
//  ViewController.swift
//  DatePicker
//
//  Created by Aleksander Maj on 01/01/2019.
//  Copyright © 2019 DonkeyRepublic. All rights reserved.
//

import UIKit


class DatePickerInputView: UIInputView {
    let datePicker = UIDatePicker()

    var height: CGFloat = 320 {
        didSet {
            heightConstraint?.constant = height
        }
    }
    private var heightConstraint: NSLayoutConstraint?

    override var inputViewStyle: UIInputView.Style {
        get { return .default }
    }

    override var allowsSelfSizing: Bool {
        get { return true }
        set {}
    }

    init() {
        super.init(frame: .zero, inputViewStyle: .default)
        addSubview(datePicker)

        translatesAutoresizingMaskIntoConstraints = false
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        let heightConstraint = datePicker.heightAnchor.constraint(equalToConstant: height)

        NSLayoutConstraint.activate([
            datePicker.topAnchor.constraint(equalTo: topAnchor),
            datePicker.bottomAnchor.constraint(equalTo: bottomAnchor),
            datePicker.leadingAnchor.constraint(equalTo: leadingAnchor),
            datePicker.trailingAnchor.constraint(equalTo: trailingAnchor),
            heightConstraint
            ])
        
        self.heightConstraint = heightConstraint
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class ViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var keyboardTextField: UITextField!

    let datePicker = DatePickerInputView()

    override func viewDidLoad() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardDidShowNotification , object: nil)

        super.viewDidLoad()
        textField.inputView = datePicker
    }

    @objc func keyboardWillShow(notification: Notification) -> CGFloat {
        NSLog("Keyboard appeared")
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            datePicker.height = keyboardSize.height
            return keyboardSize.height
        }
        return 0
    }

}

