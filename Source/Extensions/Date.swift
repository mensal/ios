import Foundation
import SwiftDate

extension Date {

    // MARK: - Conveniência

//    var gmtDay: Int? {
//        get {
//            return self.in(region: .UTC).day
//        }
//    }
//
//    var stringGMTDay: String? {
//        get {
//            return self.gmtDay != nil ? ("0" + String(self.gmtDay!)).suffix(2).description : nil
//        }
//    }
//
//    var stringGMTDay: String? {
//        get {
//            return self.gmtDay != nil ? ("0" + String(self.gmtDay!)).suffix(2).description : nil
//        }
//    }

    var stringForDatePicker: String? {
        get {
//            print("\(self) : \(self.isCurrentDay) __ \(Date.currentDay()) __ \(self.inRegion())")

//            return self.isCurrentDay ? "Hoje" : self.inGMTRegion().string(dateStyle: .short, timeStyle: .none)
            return self.isCurrentDay ? "Hoje" : date.description
        }
    }

    var iso8601Extended: String {
        get {
//            return self.inGMTRegion().iso8601(opts: .withInternetDateTimeExtended)
            return self.in(region: .current).toISO(.withInternetDateTimeExtended)
        }
    }

    var iso8601Date: String {
        get {
//            return self.inGMTRegion().iso8601(opts: .withFullDate)
            return self.in(region: .current).toISO(.withFullDate)
        }
    }

    var isCurrentYear: Bool {
        get {
            return self.year == Date.currentYear()
        }
    }

    var isCurrentMonth: Bool {
        get {
            return self.isCurrentYear && self.month == Date.currentMonth()
        }
    }

    var isCurrentDay: Bool {
        get {
            return self.isCurrentMonth && self.day == Date.currentDay()
        }
    }

    static func parse(string: String?) -> Date? {
        if let string = string {
//            return DateInRegion(string: string, format: .iso8601Auto, fromRegion: .GMT())?.toRegion(.GMT()).absoluteDate
            return DateInRegion(string, format: nil, region: .current)?.date
        }

        return nil
    }

    static func parse(iso8601String string: String?) -> Date? {
        if let string = string {
            return DateInRegion(string, format: DateFormats.iso8601, region: .current)?.date
        }

        return nil
    }

    static func parse(year: Int, month: Int, day: Int) -> Date? {
        let year   = year.description.padding(toLength: 4, withPad: "0")
        let month  = month.description.padding(toLength: 2, withPad: "0")
        let day    = day.description.padding(toLength: 2, withPad: "0")
        let string = "\(year)-\(month)-\(day)"

        return DateInRegion(string, format: nil, region: .current)?.date
    }

    static func currentYear() -> Int {
        return Date().year
    }

    static func currentMonth() -> Int {
        return Date().month
    }

    static func currentDay() -> Int {
        return Date().day
    }

    public static func monthSymbol(for month: Int16) -> String {
        return DateFormatter().monthSymbols[Int(month) - 1].capitalized
    }
}
