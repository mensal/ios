import Foundation

class Mes {
    
    // MARK: - Propriedades
    
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

    var nomeCompleto: String? {
        get {
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
    }

    var isCorrente: Bool? {
        get {
            return ano == Date.currentYear() && ordinal == Date.currentMonth()
        }
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
