import Foundation
import SwiftyJSON

class VeiculoResponse: VersionadoResponse<Veiculo> {
    var nome: String
    
    required init(_ json: JSON) {
        self.nome = json["veiculo"].string!
        super.init(json)
    }

    override func preenche(_ persistido: Veiculo) {
        super.preenche(persistido)
        persistido.nome = nome
    }
}

class VeiculoProxy: VersionadoProxy<Veiculo, VeiculoResponse> {
    
    // MARK: - Construtores

    required init() {
        super.init("/tipo/combustiveis?ano=0&mes=0")
    }
}
