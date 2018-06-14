import Foundation
import SwiftyJSON

class FixaResponse: VersionadoResponse {
    var id: UUID
    var nome: String
    var vencimento: Int

    required init(_ json: JSON) {
        self.id         = UUID(uuidString: json["id"].string!)!
        self.nome       = json["nome"].string!
        self.vencimento = json["vencimento"].int!
    }
}

class FixaProxy: VersionadoProxy<FixaResponse> {
    
    // MARK: - Construtores

    init() {
        super.init("/tipo/fixas?ano=0&mes=0")
    }
}
