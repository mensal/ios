import Foundation
import SwiftyJSON

extension JSON {
    
    // MARK: - Conveniência

    var date: Date? {
        get {
            return Date.parse(stringToDate: self.string)
        }
    }

    var uuid: UUID? {
        get {
            return UUID(uuidString: self.string ?? "")
        }
    }
}
