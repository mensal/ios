import Foundation
import SwiftDate

extension PagamentoDiarista {

    public override var description: String {
        return self.data?.in(region: .current).toFormat("EEEE").capitalized ?? ""
    }
}
