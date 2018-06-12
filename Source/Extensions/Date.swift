import Foundation
import SwiftDate

extension Date {

    // MARK: - Conveniência

    public static func currentYear() -> Int {
        return Date().year
    }

    public static func currentMonth() -> Int {
        return Date().month
    }
    
    public static func monthSymbol(for month: Int16) -> String {
        return DateFormatter().monthSymbols[Int(month) - 1].capitalized
    }
}
