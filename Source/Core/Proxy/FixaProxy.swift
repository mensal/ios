import Foundation
import SwiftyJSON
import CoreData

class FixaRequest: VersionadoRequest<Fixa> {
}

class FixaResponse: VersionadoResponse<Fixa> {
    var nome: String
    var vencimento: Int

    required init(_ json: JSON) {
        nome = json["nome"].string!
        vencimento = json["vencimento"].int!
        super.init(json)
    }

    override func preenche(_ persistido: Fixa, _ context: NSManagedObjectContext) {
        super.preenche(persistido, context)
        persistido.nome = nome
        persistido.vencimento = Int16(vencimento)
    }
}

class FixaProxy: VersionadoProxy<Fixa, FixaRequest, FixaResponse> {

    // MARK: - Construtores

    required init() {
        super.init("/tipo/fixas")
    }
}
