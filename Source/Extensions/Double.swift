import Foundation

extension Double {

    func string(fractionDigits digits: Int) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = digits
        formatter.maximumFractionDigits = digits

        return formatter.string(from: NSNumber(value: self))!
    }
}
