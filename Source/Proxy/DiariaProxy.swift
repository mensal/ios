import Foundation
import SwiftyJSON

class DiariaResponse: VersionadoResponse {
    typealias E = Diaria
    
    var id: UUID
    var valor: Double
    
    required init(_ json: JSON) {
        self.id    = UUID(uuidString: json["id"].string!)!
        self.valor = json["valor"].double!
    }
    
    func preenche(_ persistido: Diaria) {
        persistido.valor = valor
    }
}

class DiariaProxy: VersionadoProxy<DiariaResponse> {
    
    // MARK: - Construtores
    
    required init() {
        super.init("/tipo/diaristas?ano=0&mes=0")
    }
}
