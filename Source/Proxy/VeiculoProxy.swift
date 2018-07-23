import Foundation
import SwiftyJSON
import CoreData

class VeiculoRequest: VersionadoRequest<Veiculo> {
}

class VeiculoResponse: VersionadoResponse<Veiculo> {
    var nome: String

    required init(_ json: JSON) {
        nome = json["veiculo"].string!
        super.init(json)
    }

    override func preenche(_ persistido: Veiculo, _ context: NSManagedObjectContext) {
        super.preenche(persistido, context)
        persistido.nome = nome
    }
}

class VeiculoProxy: VersionadoProxy<Veiculo, VeiculoRequest, VeiculoResponse> {

    // MARK: - Construtores

    required init() {
        super.init("/tipo/combustiveis")
    }
}
