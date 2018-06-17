import Foundation

extension Pagamento {

    var total: Double {
        get {
            var total: Double = 0
            (valores?.array as? [Rateio])?.forEach { total += $0.valor }

            return total
        }
    }
}
