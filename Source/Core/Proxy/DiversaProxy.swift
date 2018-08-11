import Foundation
import SwiftyJSON
import CoreData

class DiversaRequest: VersionadoRequest<Diversa> {
}

class DiversaResponse: VersionadoResponse<Diversa> {
    var nome: String

    required init(_ json: JSON) {
        nome = json["nome"].string!
        super.init(json)
    }

    override func preenche(_ persistido: Diversa, _ context: NSManagedObjectContext) {
        super.preenche(persistido, context)
        persistido.nome = nome
    }
}

class DiversaProxy: VersionadoProxy<Diversa, DiversaRequest, DiversaResponse> {

    // MARK: - Construtores

    required init() {
        super.init("/tipo/diversas")
    }
}
