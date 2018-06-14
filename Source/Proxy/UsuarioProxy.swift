import Foundation
import SwiftyJSON

class UsuarioResponse: VersionadoResponse {
    var id: UUID
    var nome: String
    
    required init(_ json: JSON) {
        self.id         = UUID(uuidString: json["id"].string!)!
        self.nome       = json["nome"].string!
    }
}

class UsuarioProxy: VersionadoProxy<UsuarioResponse> {
    
    // MARK: - Construtores
    
    init() {
        super.init("/usuarios")
    }
}
