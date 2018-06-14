import Foundation
import SwiftyJSON

class VeiculoResponse: VersionadoResponse {
    typealias E = Veiculo
    
    var id: UUID
    var nome: String
    
    required init(_ json: JSON) {
        self.id   = UUID(uuidString: json["id"].string!)!
        self.nome = json["veiculo"].string!
    }

    func preenche(_ persistido: Veiculo) {
        persistido.nome = nome
    }
}

class VeiculoProxy: VersionadoProxy<VeiculoResponse> {
    
    // MARK: - Construtores

    required init() {
        super.init("/tipo/combustiveis?ano=0&mes=0")
    }
}
