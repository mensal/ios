import Foundation
import SwiftyJSON
import SwiftDate

class PagamentoResponse<E: Pagamento> : VersionadoResponse<E> {
    var data: Date
    var tipo: IdResponse
    var valores: [RateioResponse]

    required init(_ json: JSON) {
        self.data    = Date.parse(stringToDate: json["data"].string)!
        self.tipo    = IdResponse()
        self.tipo.id = UUID(uuidString: json["tipo"]["id"].string!)!
        self.valores = [RateioResponse]()
        
        json["valores"].forEach { _, json in
            let rateio = RateioResponse()
            
            rateio.valor      = json["valor"].double
            rateio.usuario    = IdResponse()
            rateio.usuario.id = UUID(uuidString: json["usuario"]["id"].string!)!
        }

        super.init(json)
    }
    
    override func preenche(_ persistido: E) {
        super.preenche(persistido)
        
        persistido.data = self.data
    }
}

class IdResponse {
    var id: UUID!
}

class RateioResponse {
    var valor: Double!
    var usuario: IdResponse!
}
