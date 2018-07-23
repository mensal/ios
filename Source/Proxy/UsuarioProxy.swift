import Foundation
import SwiftyJSON
import CoreData

class UsuarioRequest: VersionadoRequest<Usuario> {
}

class UsuarioResponse: VersionadoResponse<Usuario> {
    var nome: String

    required init(_ json: JSON) {
        nome = json["nome"].string!
        super.init(json)
    }

    override func preenche(_ persistido: Usuario, _ context: NSManagedObjectContext) {
        super.preenche(persistido, context)
        persistido.nome = nome
    }
}

class UsuarioProxy: VersionadoProxy<Usuario, UsuarioRequest, UsuarioResponse> {

    // MARK: - Construtores

    required init() {
        super.init("/usuarios")
    }
}
