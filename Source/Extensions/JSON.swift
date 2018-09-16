import Foundation
import SwiftyJSON

extension JSON {

    // MARK: - Conveniência

    var date: Date? {
        get {
            return Date.parse(string: self.string)
        }
    }

    var uuid: UUID? {
        get {
            return UUID(uuidString: self.string ?? "")
        }
    }
}
