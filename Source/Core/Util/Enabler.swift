import Foundation
import UIKit

class Enabler: NSObject {

    private var pairs = [(textField: UITextField, delegate: UITextFieldDelegate?)]()
    private let views: [UIView]

    init(required textFields: [UITextField], dependent views: [UIView]) {
        self.views = views
        super.init()

        textFields.forEach { textField in
            self.pairs.append((textField, textField.delegate))
            textField.delegate = self
        }
    }
}

extension Enabler: UITextFieldDelegate {

    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        let res = pairs.first { $0.textField == textField }?.delegate?.textFieldShouldBeginEditing?(textField)
        return res ?? true
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        pairs.first { $0.textField == textField }?.delegate?.textFieldDidBeginEditing?(textField)
    }

    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        let res = pairs.first { $0.textField == textField }?.delegate?.textFieldShouldEndEditing?(textField)
        return res ?? true
    }

    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        let res = pairs.first { $0.textField == textField }?.delegate?.textFieldShouldClear?(textField)
        return res ?? true
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        pairs.first { $0.textField == textField }?.delegate?.textFieldDidEndEditing?(textField)
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let res = pairs.first { $0.textField == textField }?.delegate?.textField?(textField, shouldChangeCharactersIn: range, replacementString: string)
        return res ?? true
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let res = pairs.first { $0.textField == textField }?.delegate?.textFieldShouldReturn?(textField)
        return res ?? true
    }

    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextFieldDidEndEditingReason) {
        pairs.first { $0.textField == textField }?.delegate?.textFieldDidEndEditing?(textField, reason: reason)
    }
}
