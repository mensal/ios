import Foundation
import SwiftDate

private let anoInicial = 2018
private let mesInicial = 5

class MesManager {
    
    private init() {
    }
    
    static func obterAnos() -> [Int] {
        return (anoInicial...Date.currentYear()).map { $0 }
    }
    
    static func obterTodos() -> [Mes] {
        var resultado = [Mes]()
        
        obterAnos().forEach { ano in
            let inicial = (ano == anoInicial ? mesInicial : 1)
            
            (inicial...12).forEach { mes in
                resultado.append(Mes(mes, ano: ano))
            }
        }
        
        return resultado
    }
    
    static func extrairMeses(_ meses: [Mes], ano: Int) -> [Mes] {
        return meses.filter { $0.ano == ano }
    }
}
