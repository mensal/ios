import Foundation
import SwiftDate

class Mes {

    // MARK: - Propriedades

    var ordinal: Int?

    var stringOrdinal: String? {
        return ordinal != nil ? ("0" + String(ordinal!)).suffix(2).description : nil
    }

    var ano: Int?

    var nome: String? {
        guard let ordinal = ordinal else {
            return nil
        }

        return DateFormatter().monthSymbols[ordinal - 1].capitalized
    }

    var nomeCompleto: String? {
        guard let nome = nome else {
            return nil
        }

        var complemento = ""
        if ano != Date.currentYear() {
            if let ano = ano {
                complemento = " / " + String(ano).suffix(2)
            }
        }

        return nome + complemento
    }

    var isCorrente: Bool? {
        return ano == Date.currentYear() && ordinal == Date.currentMonth()
    }

    var inicio: Date? {
        return Date.parse(year: self.ano ?? 0, month: self.ordinal ?? 0, day: 1)
    }

    var fim: Date? {
        return self.inicio?.dateAtEndOf(.month)
    }

    // MARK: - Conveniência

    static func corrente() -> Mes {
        return Mes(Date.currentMonth(), ano: Date.currentYear())
    }

    // MARK: - Construtores

    init (_ ordinal: Int, ano: Int) {
        self.ordinal = ordinal
        self.ano = ano
    }
}
