import Foundation
import SwiftyJSON
import CoreData

class DiariaResponse: VersionadoResponse<Diaria> {
    var valor: Double

    required init(_ json: JSON) {
        valor = json["valor"].double!
        super.init(json)
    }

    override func preenche(_ persistido: Diaria, _ context: NSManagedObjectContext) {
        super.preenche(persistido, context)
        persistido.valor = valor
    }
}

class DiariaProxy: VersionadoProxy<Diaria, DiariaResponse> {

    // MARK: - Construtores

    required init() {
        super.init("/tipo/diaristas?ano=0&mes=0")
    }
}
