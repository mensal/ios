import Foundation
import SwiftDate

extension Date {

    // MARK: - Conveniência

    var stringForDatePicker: String? {
        get {
            return self.isCurrentDay ? "Hoje" : date.toFormat("EEE d")
        }
    }

    var iso8601Extended: String {
        get {
            return self.in(region: .current).toISO(.withInternetDateTimeExtended)
        }
    }

    var iso8601Date: String {
        get {
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

        return DateInRegion("\(year)-\(month)-\(day)", format: nil, region: .current)?.date
    }

    static func currentYear() -> Int {
        return Date().in(region: .current).year
    }

    static func currentMonth() -> Int {
        return Date().in(region: .current).month
    }

    static func currentDay() -> Int {
        return Date().in(region: .current).day
    }

    public static func monthSymbol(for month: Int16) -> String {
        return DateFormatter().monthSymbols[Int(month) - 1].capitalized
    }
}
