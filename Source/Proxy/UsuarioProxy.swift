import Foundation
import SwiftyJSON

class UsuarioResponse: VersionadoResponse<Usuario> {
    var nome: String
    
    required init(_ json: JSON) {
        self.nome = json["nome"].string!
        super.init(json)
    }

    override func preenche(_ persistido: Usuario) {
        super.preenche(persistido)
        persistido.nome = nome
    }
}

class UsuarioProxy: VersionadoProxy<Usuario, UsuarioResponse> {
    
    // MARK: - Construtores
    
    required init() {
        super.init("/usuarios")
    }
}
