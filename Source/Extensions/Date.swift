import Foundation
import SwiftDate

extension Date {

    // MARK: - Conveniência

    var gmtDay: Int? {
        get {
            return self.inGMTRegion().day
        }
    }

    var stringGMTDay: String? {
        get {
            return self.gmtDay != nil ? ("0" + String(self.gmtDay!)).suffix(2).description : nil
        }
    }

    static func parse(stringToDate string: String?) -> Date? {
        if let string = string {
            return DateInRegion(string: string, format: .iso8601Auto, fromRegion: .GMT())?.toRegion(.GMT()).absoluteDate
        }
        
        return nil
    }
    
    static func parse(stringToTimestamp string: String?) -> Date? {
        if let string = string {
            return DateInRegion(string: string, format: .iso8601Auto)?.absoluteDate
        }
        
        return nil
    }
    
    static func currentYear() -> Int {
        return Date().year
    }

    static func currentMonth() -> Int {
        return Date().month
    }
    
    public static func monthSymbol(for month: Int16) -> String {
        return DateFormatter().monthSymbols[Int(month) - 1].capitalized
    }
}
