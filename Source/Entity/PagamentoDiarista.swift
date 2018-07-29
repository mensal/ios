import Foundation

extension PagamentoDiarista {
    
    public override var description: String {
        return self.data?.inGMTRegion().string(custom: "EEEE").capitalized ?? ""
    }
}
