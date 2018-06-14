import Foundation
import SwiftyJSON
import CoreData

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

class VeiculoProxy: VersionadoProxy<Veiculo, VeiculoResponse> {
    
    // MARK: - Construtores

    required init() {
        super.init("/tipo/combustiveis?ano=0&mes=0")
    }
}
