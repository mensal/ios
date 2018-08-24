import Foundation
import UIKit

private typealias Pair = (textField: UITextField, delegate: UITextFieldDelegate?)

class Enabler: NSObject {

    private var pairs = [Pair]()
    private let views: [UIView]

    init(required textFields: [UITextField], dependent views: [UIView]) {
        self.views = views
        super.init()

        textFields.forEach { textField in
            self.pairs.append((textField, textField.delegate))
            textField.delegate = self
        }
    }
    
    private func pair(with textField: UITextField) -> Pair? {
        return pairs.first { $0.textField == textField }
    }
    
    private func pairs(without textField: UITextField) -> [Pair]? {
        return pairs.filter { $0.textField != textField }
    }
    
    private func isAllEmpty(_ textField: UITextField) -> Bool {
        var isEmpty = true
        
        isEmpty = isEmpty && textField.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true
        
        return isEmpty
    }
}

extension Enabler: UITextFieldDelegate {

    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        let res = pair(with: textField)?.delegate?.textFieldShouldBeginEditing?(textField)
        return res ?? true
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        pair(with: textField)?.delegate?.textFieldDidBeginEditing?(textField)
    }

    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        let res = pair(with: textField)?.delegate?.textFieldShouldEndEditing?(textField)
        return res ?? true
    }

    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        let res = pair(with: textField)?.delegate?.textFieldShouldClear?(textField)
        return res ?? true
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        pair(with: textField)?.delegate?.textFieldDidEndEditing?(textField)
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let p = pair(with: textField)
        let o = pairs(without: textField)
        
        //
        
        let res = p?.delegate?.textField?(textField, shouldChangeCharactersIn: range, replacementString: string)
        return res ?? true
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let res = pair(with: textField)?.delegate?.textFieldShouldReturn?(textField)
        return res ?? true
    }

    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextFieldDidEndEditingReason) {
        pair(with: textField)?.delegate?.textFieldDidEndEditing?(textField, reason: reason)
    }
}
