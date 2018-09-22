import Foundation

extension Pagamento {

    var total: Double {
        var total: Double = 0
        rateiosArray?.forEach { total += $0.valor }

        return total
    }

    var rateiosArray: [Rateio]? {
        return self.rateios?.array as? [Rateio]
    }
}
