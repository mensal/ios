import Foundation
import SwiftyJSON

import Foundation
import Alamofire
import AlamofireSwiftyJSON
import SwiftyJSON

class DiversaResponse: VersionadoResponse {
    var id: UUID
    var nome: String
    
    required init(_ json: JSON) {
        self.id         = UUID(uuidString: json["id"].string!)!
        self.nome       = json["nome"].string!
    }
}

class DiversaProxy: VersionadoProxy<DiversaResponse> {
    
    // MARK: - Construtores
    
    init() {
        super.init("/tipo/diversas?ano=0&mes=0")
    }
}
