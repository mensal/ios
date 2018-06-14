import Foundation
import SwiftyJSON

class FixaResponse: VersionadoResponse {
    typealias E = Fixa
    
    var id: UUID
    var nome: String
    var vencimento: Int

    required init(_ json: JSON) {
        self.id         = UUID(uuidString: json["id"].string!)!
        self.nome       = json["nome"].string!
        self.vencimento = json["vencimento"].int!
    }

    func preenche(_ persistido: Fixa) {
        persistido.nome = nome
        persistido.vencimento = Int16(vencimento)
    }
}

class FixaProxy: VersionadoProxy<FixaResponse> {
    
    // MARK: - Construtores

    required init() {
        super.init("/tipo/fixas?ano=0&mes=0")
    }
}
