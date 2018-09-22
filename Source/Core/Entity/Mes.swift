import Foundation
import SwiftDate

class Mes {

    // MARK: - Propriedades

    var ordinal: Int?

    var stringOrdinal: String? {
        //        get {
        return ordinal != nil ? ("0" + String(ordinal!)).suffix(2).description : nil
        //        }
    }

    var ano: Int?

    var nome: String? {
        //        get {
        guard let ordinal = ordinal else {
            return nil
        }

        return DateFormatter().monthSymbols[ordinal - 1].capitalized
        //        }
    }

    var nomeCompleto: String? {
        //        get {
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
        //        }
    }

    var isCorrente: Bool? {
        //        get {
        return ano == Date.currentYear() && ordinal == Date.currentMonth()
        //        }
    }

    //    private var inicioInRegion: Date? {
    //        get {
    //            return Date.parse(year: self.ano ?? 0, month: self.ordinal ?? 0, day: 1)
    //        }
    //    }

    var inicio: Date? {
        //        get {
        //            return self.inicioInRegion
        return Date.parse(year: self.ano ?? 0, month: self.ordinal ?? 0, day: 1)
        //        }
    }

    var fim: Date? {
        //        get {
        return self.inicio?.dateAtEndOf(.month)
        //        }
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
