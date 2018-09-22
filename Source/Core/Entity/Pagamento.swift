import Foundation

extension Pagamento {

    var total: Double {
        //        get {
        var total: Double = 0
        rateiosArray?.forEach { total += $0.valor }

        return total
        //        }
    }

    var rateiosArray: [Rateio]? {
        //        get {
        return self.rateios?.array as? [Rateio]
        //        }
    }
}
