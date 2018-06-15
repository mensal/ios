import Foundation

extension Pagamento {
    
    var total: Double {
        get {
            var total: Double = 0
            (valores?.array as? [Rateio])?.forEach { total += $0.valor }
            
            return total
        }
    }
    
    var stringTotal: String {
        get {
            let formatter = NumberFormatter()
            formatter.numberStyle = .decimal
            formatter.minimumFractionDigits = 2
            formatter.maximumFractionDigits = 2
            
            return formatter.string(from: NSNumber(value: self.total))!
        }
    }
}
