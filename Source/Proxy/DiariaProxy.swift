import Foundation
import SwiftyJSON

class DiariaResponse: VersionadoResponse<Diaria> {
    var valor: Double
    
    required init(_ json: JSON) {
        self.valor = json["valor"].double!
        super.init(json)
    }
    
    override func preenche(_ persistido: Diaria) {
        super.preenche(persistido)
        persistido.valor = valor
    }
}

class DiariaProxy: VersionadoProxy<Diaria, DiariaResponse> {
    
    // MARK: - Construtores
    
    required init() {
        super.init("/tipo/diaristas?ano=0&mes=0")
    }
}
