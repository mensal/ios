import Foundation
import SwiftyJSON

import Foundation
import Alamofire
import AlamofireSwiftyJSON
import SwiftyJSON

class DiversaResponse: VersionadoResponse<Diversa> {
    var nome: String
    
    required init(_ json: JSON) {
        self.nome = json["nome"].string!
        super.init(json)
    }

    override func preenche(_ persistido: Diversa) {
        super.preenche(persistido)
        persistido.nome = nome
    }
}

class DiversaProxy: VersionadoProxy<Diversa, DiversaResponse> {
    
    // MARK: - Construtores
    
    required init() {
        super.init("/tipo/diversas?ano=0&mes=0")
    }
}
