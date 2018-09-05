import Foundation
import SwiftyJSON
import CoreData

class UsuarioRequest: VersionadoRequest<Usuario> {
}

class UsuarioResponse: VersionadoResponse<Usuario> {
    var nome: String
    var email: String

    required init(_ json: JSON) {
        nome  = json["nome"].stringValue
        email = json["email"].stringValue

        super.init(json)
    }

    override func preenche(_ persistido: Usuario, _ context: NSManagedObjectContext) {
        super.preenche(persistido, context)

        persistido.nome  = nome
        persistido.email = email
    }
}

class UsuarioProxy: VersionadoProxy<Usuario, UsuarioRequest, UsuarioResponse> {

    // MARK: - Construtores

    required init() {
        super.init("/usuarios")
    }
}
