import Foundation
import SwiftyJSON

class UsuarioResponse: VersionadoResponse {
    typealias E = Usuario
    
    var id: UUID
    var nome: String
    
    required init(_ json: JSON) {
        self.id   = UUID(uuidString: json["id"].string!)!
        self.nome = json["nome"].string!
    }

    func preenche(_ persistido: Usuario) {
        persistido.nome = nome
    }
}

class UsuarioProxy: VersionadoProxy<UsuarioResponse> {
    
    // MARK: - Construtores
    
    required init() {
        super.init("/usuarios")
    }
}
