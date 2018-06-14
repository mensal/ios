import Foundation
import SwiftyJSON

class DiariaResponse: VersionadoResponse {
    var id: UUID
    var valor: Double
    
    required init(_ json: JSON) {
        self.id    = UUID(uuidString: json["id"].string!)!
        self.valor = json["valor"].double!
    }
}

class DiariaProxy: VersionadoProxy<DiariaResponse> {
    
    // MARK: - Construtores
    
    init() {
        super.init("/tipo/diaristas?ano=0&mes=0")
    }
}
