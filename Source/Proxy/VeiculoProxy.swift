import Foundation
import SwiftyJSON

class VeiculoResponse: VersionadoResponse {
    var id: UUID
    var nome: String
    
    required init(_ json: JSON) {
        self.id         = UUID(uuidString: json["id"].string!)!
        self.nome       = json["veiculo"].string!
    }
}

class VeiculoProxy: VersionadoProxy<VeiculoResponse> {
    
    // MARK: - Construtores

    init() {
        super.init("/tipo/combustiveis?ano=0&mes=0")
    }
}
