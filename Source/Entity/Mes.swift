import Foundation

class Mes {
    
    var ordinal: Int?
    
    var ano: Int?
    
    var nome: String? {
        get {
            guard let ordinal = ordinal else {
                return nil
            }
            
            return DateFormatter().monthSymbols[ordinal - 1].capitalized
        }
    }
    
    init (_ ordinal: Int, ano: Int) {
        self.ordinal = ordinal
        self.ano = ano
    }
}
