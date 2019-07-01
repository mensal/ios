import Foundation
import SwiftDate

private let anoInicial = 2018
private let mesInicial = 5
private let mesesAntes = 1

class MesManager {

    // MARK: - Construtores

    private init() {
    }

    // MARK: - Públicos

    static func obterAnos() -> [Int] {
        return (anoInicial...Date.currentYear()).map { $0 }
    }

    static func obterTodos() -> [Mes] {
        var resultado = [Mes]()

        obterAnos().forEach { ano in
            let inicial = (ano == anoInicial ? mesInicial : 1)
            let final   = (ano == Date.currentYear() ? Date.currentMonth() + mesesAntes : 12)

            (inicial...final).forEach { mes in
                resultado.append(Mes(mes, ano: ano))
            }
        }

        return resultado
    }

    static func extrairMeses(_ meses: [Mes], ano: Int) -> [Mes] {
        return meses.filter { $0.ano == ano }
    }
}
