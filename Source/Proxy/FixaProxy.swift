import Foundation
import SwiftyJSON

class FixaResponse: VersionadoResponse<Fixa> {
    var nome: String
    var vencimento: Int

    required init(_ json: JSON) {
        self.nome       = json["nome"].string!
        self.vencimento = json["vencimento"].int!
        super.init(json)
    }

    override func preenche(_ persistido: Fixa) {
        super.preenche(persistido)
        persistido.nome = nome
        persistido.vencimento = Int16(vencimento)
    }
}

class FixaProxy: VersionadoProxy<Fixa, FixaResponse> {
    
    // MARK: - Construtores

    required init() {
        super.init("/tipo/fixas?ano=0&mes=0")
    }
}
