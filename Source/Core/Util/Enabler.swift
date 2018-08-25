import Foundation
import UIKit

private typealias Pair = (textField: UITextField, delegate: UITextFieldDelegate?)

class Enabler: NSObject {

    private var pairs = [Pair]()
    private let controls: [UIControl]

    init(required textFields: [UITextField], dependent controls: [UIControl]) {
        self.controls = controls
        super.init()

        textFields.forEach {
            self.pairs.append(($0, $0.delegate))
            $0.delegate = self
        }
    }

    private func pair(with textField: UITextField) -> Pair? {
        return pairs.first { $0.textField == textField }
    }

    private func pairs(without textField: UITextField) -> [Pair]? {
        return pairs.filter { $0.textField != textField }
    }

    private func isAnyEmpty(skip textField: UITextField, check text: String?) -> Bool {
        var isEmpty = text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true
        pairs(without: textField)?.forEach { isEmpty = isEmpty || $0.textField.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true }

        return isEmpty
    }

    private func updateControlsState(skip textField: UITextField, check text: String?) {
        if isAnyEmpty(skip: textField, check: text) {
            controls.forEach { updateControl($0, isEnable: false) }
        } else {
            controls.forEach { updateControl($0, isEnable: true) }
        }
    }

    private func updateControl(_ control: UIControl, isEnable: Bool) {
        if control.isEnabled != isEnable {
            UIView.animate(withDuration: 0.2) {
                control.isEnabled = isEnable
            }
        }
    }
}

extension Enabler: UITextFieldDelegate {

    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return pair(with: textField)?.delegate?.textFieldShouldBeginEditing?(textField) ?? true
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        pair(with: textField)?.delegate?.textFieldDidBeginEditing?(textField)
    }

    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return pair(with: textField)?.delegate?.textFieldShouldEndEditing?(textField) ?? true
    }

    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        updateControlsState(skip: textField, check: nil)

        return pair(with: textField)?.delegate?.textFieldShouldClear?(textField) ?? true
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        pair(with: textField)?.delegate?.textFieldDidEndEditing?(textField)
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let text = (textField.text as NSString?)?.replacingCharacters(in: range, with: string)
        updateControlsState(skip: textField, check: text)

        return pair(with: textField)?.delegate?.textField?(textField, shouldChangeCharactersIn: range, replacementString: string) ?? true
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return pair(with: textField)?.delegate?.textFieldShouldReturn?(textField) ?? true
    }

    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextFieldDidEndEditingReason) {
        pair(with: textField)?.delegate?.textFieldDidEndEditing?(textField, reason: reason)
    }
}
